package com.example.vehicles.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.vehicles.model.Vehicle;

public interface VehicleRepository extends JpaRepository<Vehicle, Long> {
}
