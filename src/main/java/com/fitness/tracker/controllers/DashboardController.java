package com.fitness.tracker.controllers;

import com.fitness.tracker.entities.Performance;
import com.fitness.tracker.entities.TrainingProgram;
import com.fitness.tracker.entities.User;
import com.fitness.tracker.repositories.TrainingProgramRepository;
import com.fitness.tracker.services.PerformanceService;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class DashboardController {

    @Autowired
    private TrainingProgramRepository trainingProgramRepository;

    @Autowired
    private PerformanceService performanceService;

    @GetMapping("/")
    public String home() {
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String showRootLogin(HttpSession session) {
        if (session.getAttribute("loggedInUser") != null) {
            return "redirect:/dashboard";
        }
        return "login";
    }

    @PostMapping("/login")
    public String rootLoginRedirect() {
        return "forward:/auth/login";
    }

    @PostMapping("/register")
    public String rootRegisterRedirect() {
        return "forward:/auth/register";
    }

    @GetMapping("/logout")
    public String rootLogoutRedirect() {
        return "redirect:/auth/logout";
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User user = getLoggedInUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("user", user);
        model.addAttribute("programs", trainingProgramRepository.findAllByOrderByNameAsc());
        model.addAttribute("today", LocalDate.now());
        return "dashboard";
    }

    @PostMapping("/log-performance")
    public String logPerformance(
            @RequestParam Long programId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate performanceDate,
            @RequestParam Integer durationPerformed,
            @RequestParam(required = false) Double distanceKm,
            @RequestParam(required = false) String notes,
            HttpSession session,
            RedirectAttributes redirectAttributes
    ) {
        User user = getLoggedInUser(session);
        if (user == null) {
            return "redirect:/login";
        }

        try {
            TrainingProgram program = trainingProgramRepository.findById(programId)
                    .orElseThrow(() -> new IllegalArgumentException("Selected training program was not found."));
            Performance performance = buildPerformance(user, program, performanceDate, durationPerformed, distanceKm, notes);
            performanceService.savePerformance(performance);
            redirectAttributes.addFlashAttribute("success", "Performance logged successfully.");
        } catch (IllegalArgumentException exception) {
            redirectAttributes.addFlashAttribute("error", exception.getMessage());
        }
        return "redirect:/dashboard";
    }

    private User getLoggedInUser(HttpSession session) {
        Object user = session.getAttribute("loggedInUser");
        if (user instanceof User loggedInUser) {
            return loggedInUser;
        }
        return null;
    }

    private Performance buildPerformance(
            User user,
            TrainingProgram program,
            LocalDate performanceDate,
            Integer durationPerformed,
            Double distanceKm,
            String notes
    ) {
        Performance performance = new Performance();
        performance.setUser(user);
        performance.setProgram(program);
        performance.setPerformanceDate(performanceDate);
        performance.setDurationPerformed(durationPerformed);
        performance.setDistanceKm(distanceKm);
        performance.setNotes(notes == null || notes.trim().isEmpty() ? null : notes.trim());
        return performance;
    }
}
