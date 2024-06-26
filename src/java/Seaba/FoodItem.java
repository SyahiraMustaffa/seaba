package Seaba;

import java.sql.Blob;
import java.sql.SQLException;
import java.util.Base64;

public class FoodItem {
    private int id;
    private String food_Name;
    private String description;
    private double price;
    private byte[] imageBytes;

    // Constructors, getters, and setters
    // Constructor
    public FoodItem() {}

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFoodName() {
        return food_Name;
    }

    public void setFoodName(String foodName) {
        this.food_Name = foodName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public byte[] getImageBytes() {
        return imageBytes;
    }

    public void setImageBytes(byte[] imageBytes) {
        this.imageBytes = imageBytes;
    }

    // Helper method to convert image bytes to Base64 string for HTML display
    public String getImageBase64() {
        if (imageBytes != null) {
            return Base64.getEncoder().encodeToString(imageBytes);
        } else {
            return null;
        }
    }
}
