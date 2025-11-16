package com.example.vehicles.service;

import org.springframework.stereotype.Service;
import com.example.vehicles.model.Vehicle;
import com.example.vehicles.repository.VehicleRepository;
import java.util.List;

@Service
public class VehicleService {

    private final VehicleRepository repository;

    public VehicleService(VehicleRepository repository) {
        this.repository = repository;
    }

    public Vehicle save(Vehicle vehicle) {
        return repository.save(vehicle);
    }

    public List<Vehicle> findAll() {
        return repository.findAll();
    }

    public Vehicle findById(Long id) {
        return repository.findById(id).orElse(null);
    }

    public Vehicle update(Long id, Vehicle vehicle) {
        Vehicle existing = repository.findById(id).orElseThrow();
        existing.setModel(vehicle.getModel());
        existing.setBrand(vehicle.getBrand());
        existing.setYear(vehicle.getYear());
        existing.setColor(vehicle.getColor());
        existing.setPrice(vehicle.getPrice());
        existing.setMileage(vehicle.getMileage());
        existing.setStatus(vehicle.getStatus());
        return repository.save(existing);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }
}
