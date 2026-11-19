package ua.edu.kntu.panchyshkin.cicdlab;
import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;
public class MainActivity extends Activity {
    @Override public void onCreate(Bundle state) {
        super.onCreate(state);
        TextView text = new TextView(this);
        text.setText("CI/CD інструментарій\nПанчишкін Богдан Олександрович\n3ПРс/3");
        text.setTextSize(22);
        text.setPadding(32, 48, 32, 32);
        setContentView(text);
    }
}
