package com.fitness.tracker.services;

import com.fitness.tracker.entities.Performance;
import com.fitness.tracker.entities.User;
import java.time.LocalDate;
import java.util.List;

public interface PerformanceService {

    Performance savePerformance(Performance performance);

    List<Performance> getUserPerformances(User user);

    List<Performance> getUserPerformancesWithFilters(User user, LocalDate startDate, LocalDate endDate, Long programId);

    Double getAverageDuration(User user);
}
