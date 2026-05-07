package com.fitness.tracker.repositories;

import com.fitness.tracker.entities.TrainingProgram;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TrainingProgramRepository extends JpaRepository<TrainingProgram, Long> {

    List<TrainingProgram> findAllByOrderByNameAsc();

    List<TrainingProgram> findByCategory(String category);
}
