package com.fitness.tracker.repositories;

import com.fitness.tracker.entities.Performance;
import com.fitness.tracker.entities.TrainingProgram;
import com.fitness.tracker.entities.User;
import java.time.LocalDate;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PerformanceRepository extends JpaRepository<Performance, Long> {

    List<Performance> findByUserOrderByPerformanceDateDesc(User user);

    List<Performance> findByUserAndPerformanceDateBetween(User user, LocalDate startDate, LocalDate endDate);

    List<Performance> findByUserAndProgram(User user, TrainingProgram program);

    List<Performance> findByUserAndPerformanceDateBetweenAndProgram(
            User user,
            LocalDate startDate,
            LocalDate endDate,
            TrainingProgram program
    );
}
