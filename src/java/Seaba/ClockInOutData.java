package Seaba;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ClockInOutData {
    private Date clockIn;
    private Date clockOut;

    public ClockInOutData(String clockIn, String clockOut) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");

        this.clockIn = dateFormat.parse(clockIn);
        this.clockOut = dateFormat.parse(clockOut);
    }

    public Date getClockIn() {
        return clockIn;
    }

    public Date getClockOut() {
        return clockOut;
    }

    // Calculate total hours and overtime
    public int getTotalHours() {
        long diff = clockOut.getTime() - clockIn.getTime();
        int totalMinutes = (int) (diff / (60 * 1000));
        return totalMinutes / 60;
    }

    public int getOvertime() {
        int totalMinutes = getTotalHours() * 60;
        int overtimeMinutes = Math.max(0, totalMinutes - 8 * 60);
        return overtimeMinutes / 60;
    }
}
