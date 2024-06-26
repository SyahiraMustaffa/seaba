/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Seaba;

/**
 *
 * @author user
 */
import java.sql.*;

public class WorkWeekBean {
    private int id;
    private String currentWorkWeek;
    private String day;
    private Time startTime;
    private Time endTime;
    private double totalHours;

    public WorkWeekBean() {
        // Default constructor
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCurrentWorkWeek() {
        return currentWorkWeek;
    }

    public void setCurrentWorkWeek(String currentWorkWeek) {
        this.currentWorkWeek = currentWorkWeek;
    }

    public String getDay() {
        return day;
    }

    public void setDay(String day) {
        this.day = day;
    }

    public Time getStartTime() {
        return startTime;
    }

    public void setStartTime(Time startTime) {
        this.startTime = startTime;
    }

    public Time getEndTime() {
        return endTime;
    }

    public void setEndTime(Time endTime) {
        this.endTime = endTime;
    }

    public double getTotalHours() {
        return totalHours;
    }

    public void setTotalHours(double totalHours) {
        this.totalHours = totalHours;
    }
}

