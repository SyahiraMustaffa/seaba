package Seaba;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

public class DateFormatterTag extends SimpleTagSupport {
    private String inputDate;

    public void setInputDate(String inputDate) {
        this.inputDate = inputDate;
    }

    @Override
    public void doTag() throws JspException, IOException {
        try {
            SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            SimpleDateFormat outputFormat = new SimpleDateFormat("dd/M/yyyy h:mm a");
            Date date = inputFormat.parse(inputDate);

            JspWriter out = getJspContext().getOut();
            out.print(outputFormat.format(date));
        } catch (ParseException e) {
            throw new JspException("Error formatting date", e);
        }
    }
}
