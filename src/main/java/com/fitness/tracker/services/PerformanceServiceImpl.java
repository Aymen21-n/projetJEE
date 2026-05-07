package com.fitness.tracker.services;

import com.fitness.tracker.entities.Performance;
import com.fitness.tracker.entities.TrainingProgram;
import com.fitness.tracker.entities.User;
import com.fitness.tracker.repositories.PerformanceRepository;
import com.fitness.tracker.repositories.TrainingProgramRepository;
import java.time.LocalDate;
import java.util.Comparator;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PerformanceServiceImpl implements PerformanceService {

    @Autowired
    private PerformanceRepository performanceRepository;

    @Autowired
    private TrainingProgramRepository trainingProgramRepository;

    @Override
    public Performance savePerformance(Performance performance) {
        if (performance == null) {
            throw new IllegalArgumentException("Performance is required.");
        }
        if (performance.getUser() == null) {
            throw new IllegalArgumentException("A logged-in user is required.");
        }
        if (performance.getProgram() == null || performance.getProgram().getId() == null) {
            throw new IllegalArgumentException("Training program is required.");
        }
        if (performance.getPerformanceDate() == null) {
            throw new IllegalArgumentException("Performance date is required.");
        }
        if (performance.getDurationPerformed() == null || performance.getDurationPerformed() < 1) {
            throw new IllegalArgumentException("Duration performed must be at least 1 minute.");
        }
        return performanceRepository.save(performance);
    }

    @Override
    public List<Performance> getUserPerformances(User user) {
        if (user == null) {
            return List.of();
        }
        return performanceRepository.findByUserOrderByPerformanceDateDesc(user);
    }

    @Override
    public List<Performance> getUserPerformancesWithFilters(User user, LocalDate startDate, LocalDate endDate, Long programId) {
        if (user == null) {
            return List.of();
        }

        boolean hasStartDate = startDate != null;
        boolean hasEndDate = endDate != null;
        boolean hasProgram = programId != null;

        List<Performance> performances;
        if (!hasStartDate && !hasEndDate && !hasProgram) {
            performances = performanceRepository.findByUserOrderByPerformanceDateDesc(user);
        } else {
            LocalDate effectiveStartDate = hasStartDate ? startDate : LocalDate.of(1900, 1, 1);
            LocalDate effectiveEndDate = hasEndDate ? endDate : LocalDate.of(9999, 12, 31);

            if (effectiveStartDate.isAfter(effectiveEndDate)) {
                LocalDate temporaryDate = effectiveStartDate;
                effectiveStartDate = effectiveEndDate;
                effectiveEndDate = temporaryDate;
            }

            if (hasProgram) {
                TrainingProgram program = trainingProgramRepository.findById(programId).orElse(null);
                if (program == null) {
                    return List.of();
                }
                performances = performanceRepository.findByUserAndPerformanceDateBetweenAndProgram(
                        user,
                        effectiveStartDate,
                        effectiveEndDate,
                        program
                );
            } else {
                performances = performanceRepository.findByUserAndPerformanceDateBetween(user, effectiveStartDate, effectiveEndDate);
            }
        }

        return performances.stream()
                .sorted(Comparator.comparing(Performance::getPerformanceDate).reversed()
                        .thenComparing(Performance::getId, Comparator.nullsLast(Comparator.reverseOrder())))
                .toList();
    }

    @Override
    public Double getAverageDuration(User user) {
        List<Performance> performances = getUserPerformances(user);
        if (performances.isEmpty()) {
            return 0.0;
        }
        return performances.stream()
                .mapToInt(Performance::getDurationPerformed)
                .average()
                .orElse(0.0);
    }
}
