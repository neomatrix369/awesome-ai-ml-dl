package deepnetts.examples.util;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;

// utiltity class for writing and reading 2d array to/from file
public class CsvFile {

    public static void write(double[][] data, String fileName) throws FileNotFoundException {
        PrintWriter pw = new PrintWriter(fileName);
        for(int i=0; i<data.length; i++) {
            pw.print(data[i][0]);
            pw.print(",");
            pw.println(data[i][1]);
        }
        pw.close();
    }

    public static double[][] read(String fileName, int lines) {
        BufferedReader br = null;
        try {
            double[][] data = new double[lines][2];
            br = new BufferedReader(new FileReader(fileName));
            for(int i=0; i<data.length; i++) {
                String line = br.readLine();
                String[] strVals = line.split(",");
                data[i][0] = Double.parseDouble(strVals[0]);
                data[i][1] = Double.parseDouble(strVals[1]);
            }   br.close();
            return data;
        } catch (FileNotFoundException ex) {
            Logger.getLogger(CsvFile.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(CsvFile.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                br.close();
            } catch (IOException ex) {
                Logger.getLogger(CsvFile.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }

        public static void write3D(double[][] data, String fileName) throws FileNotFoundException {
        PrintWriter pw = new PrintWriter(fileName);
        for(int i=0; i<data.length; i++) {
            pw.print(data[i][0]);
            pw.print(",");
            pw.print(data[i][1]);
            pw.print(",");
            pw.println(data[i][2]);
        }
        pw.close();
    }

}
