package deepnetts.examples.util;

import deepnetts.data.DataSets;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import org.knowm.xchart.SwingWrapper;
import org.knowm.xchart.XYChart;
import org.knowm.xchart.XYChartBuilder;
import org.knowm.xchart.XYSeries;
import org.knowm.xchart.style.Styler;

/**
 *
 * @author zoran sevarac
 */
public class Plot {
    public static void lineChart(String title, String xAxisLabel, String yAxisLabel, double[][] data) {
        List<Double> xData = new ArrayList<>();
        List<Double> yData = new ArrayList<>();
        for (int i = 0; i < data.length; i++) {
          xData.add(data[i][0]);
          yData.add(data[i][1]);
        }

        // Create Chart
        XYChart chart = new XYChartBuilder().width(800).height(600).title(title).xAxisTitle(xAxisLabel).yAxisTitle(yAxisLabel).build();

        // Customize Chart
        chart.getStyler().setChartTitleVisible(true);
        chart.getStyler().setLegendPosition(Styler.LegendPosition.InsideNW);
        chart.getStyler().setXAxisLabelRotation(45);

        // Series
        chart.addSeries("Data", xData, yData);

        // display chart
        new SwingWrapper<>(chart).displayChart(title);
    }

    public static void scatter(double[][] data, String title, String xAxisLabel, String yAxisLabel) {
        // Create Chart
        XYChart chart = new XYChartBuilder().width(800).height(600).title(title).xAxisTitle(xAxisLabel).yAxisTitle(yAxisLabel).build();

        // Customize Chart
        chart.getStyler().setDefaultSeriesRenderStyle(XYSeries.XYSeriesRenderStyle.Scatter);
        chart.getStyler().setLegendPosition(Styler.LegendPosition.InsideN);

        // Series
        List<Double> xData = new ArrayList<>();
        List<Double> yData = new ArrayList<>();
        for (int i = 0; i < data.length; i++) {
          xData.add(data[i][0]);
          yData.add(data[i][1]);
        }
        chart.addSeries("Data", xData, yData);

        new SwingWrapper<>(chart).displayChart(title);

//        return chart;
    }

    public static void scatter(double[][] data, String title) {
            scatter(data, title, "X", "Y");
    }

    public static void scatter(double[][] data) {
            scatter(data, "Scatter Chart", "X", "Y");
    }

//    public static void scatter(String csvFile) throws FileNotFoundException, IOException {
//        try (BufferedReader br = new BufferedReader(new FileReader(csvFile)) ) {
//            String line="";
//
//            while(line!=null) {
//                line = br.readLine();
//                String[] numStrs = line.split(",");
//            }
//        }
//    }


}
