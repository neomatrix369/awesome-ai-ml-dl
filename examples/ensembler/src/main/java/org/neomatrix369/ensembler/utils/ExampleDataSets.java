package deepnetts.examples.util;

import deepnetts.data.TabularDataSet;

import deepnetts.data.DataSets;
import java.io.File;
import java.io.IOException;
import javax.visrec.ml.data.DataSet;
import deepnetts.data.ImageSet;
import deepnetts.data.MLDataItem;
import deepnetts.data.TabularDataSet;

/**
 * TODO: add breast cancer, mnist  and other UCI stuff
 * @author Zoran
 */
public class ExampleDataSets {

    public static TabularDataSet iris() throws IOException {
       // TODO: apply some normalization here, as a param?
       return (TabularDataSet) DataSets.readCsv("datasets/iris_data_normalised.txt", 4, 3);
    }

    public static TabularDataSet xor() {
        TabularDataSet dataSet = new TabularDataSet(2, 1);

        MLDataItem item1 = new TabularDataSet.Item(new float[] {0, 0}, new float[] {0});
        dataSet.add(item1);

        MLDataItem item2 = new TabularDataSet.Item(new float[] {0, 1}, new float[] {1});
        dataSet.add(item2);

        MLDataItem item3 = new TabularDataSet.Item(new float[] {1, 0}, new float[] {1});
        dataSet.add(item3);

        MLDataItem item4 = new TabularDataSet.Item(new float[] {1, 1}, new float[] {0});
        dataSet.add(item4);

        return dataSet;
    }


    public static ImageSet mnist() {
        String labelsFile = "D:\\datasets\\mnist\\train\\labels.txt";
        String trainingFile = "D:\\datasets\\mnist\\train\\train.txt"; // 1000 cifara - probaj sa 10 00        
        
        ImageSet imageSet = new ImageSet(28, 28);
        imageSet.setInvertImages(true);
        imageSet.loadLabels(new File(labelsFile));
        imageSet.loadImages(new File(trainingFile), 1000);
        
        return imageSet;
    }
}
