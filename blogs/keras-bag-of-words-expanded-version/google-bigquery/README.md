### BigQuery

**Log into BigQuery**

**Sign into your Google account**

![image](01-google-account-sign-in.png)

**Create a project**

[https://console.developers.google.com/cloud-resource-manager?pli=1]()

![image](02-google-create-project-01.png)

Click on the CREATE PROJECT button

![image](03-google-create-project-02.png)

Click on CREATE

**Grant permissions for project [project name]**

[https://console.cloud.google.com/iam-admin/iam?project=[project name]]()

Click on the ADD button, add an email address and select a role (i.e. BigQuery Admin), click on SAVE.

![image](04-add-member-to-project.png)

**Enable Billing**

https://console.cloud.google.com/home/dashboard?project=[project name]

Click on the Navigation menu (top-left corner), and then on Billing:

![image](05-enable-billing.png)

**Enable BigQuery API**

[https://console.cloud.google.com/flows/enableapi?apiid=bigquery&_ga=2.153440568.-1610979097.1525859407]()

![image](06-enable-BigQuery-API.png)

**Navigate to the BigQuery console**

[https://bigquery.cloud.google.com/]()

Select your project and click on Continue

![image](07-BigQuery-Web-Console.png)

Add credentials to your project

![image](08-add-credentials.png)

Enter credentials for Service account

![image](09-add-credentials-for-service-accounts.png)

Confirmation

![image](11-credentials-confirmation.png)

Simultaneously, creates Credentials as a `json` file and downloads it for safe-keeping

```json
{
  "type": "service_account",
  "project_id": "keras-so-tags-classification",
  "private_key_id": "2[some id]d",
  "private_key": "-----BEGIN PRIVATE KEY-----[some private key]\n-----END PRIVATE KEY-----\n",
  "client_email": "keras-so-tags-classification@keras-so-tags-classification.iam.gserviceaccount.com",
  "client_id": "10[your client id]27",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/keras-so-tags-classification%40keras-so-tags-classification.iam.gserviceaccount.com"
}
```

### BigQuery Console

#### Public Data: SO posts

[https://bigquery.cloud.google.com/]()

Switch to your project in the BigQuery Console

![image](10-BigQuery-console.png)

#### SQL query

[https://bigquery.cloud.google.com/savedquery/513927984416:c494494324be4a80b1fc55f613abb39c]()

#### Query on GitHub

[https://github.com/tensorflow/workshops/blob/master/extras/keras-bag-of-words/stack-overflow-query.sql]()

#### Actual SQL Query

```sql
# This query will get 2000 SO posts for the top 20 tags to be fed into our Keras model 
# Here we're only selecting posts with a single tag to keep things simple
# The regex preprocesses the text (strips newlines, commas, and <p> tags), this makes it easier for our model to interpret the text
# We're using partitioning to control the number of posts we get for each tag

SELECT post, tags FROM (
  SELECT 
    TRIM(LOWER(REGEXP_REPLACE(CONCAT(title, ' ', body), r'["\n\'?,]|<p>|</p>'," "))) as post,
    tags,
    row_number() over(partition by tags) row_num
  FROM `bigquery-public-data.stackoverflow.posts_questions` a
  WHERE tags IN ("javascript", "java", "c#", "php", "android", "jquery", "python", "html", "c++", "ios", "css", "mysql", "sql", "asp.net", "ruby-on-rails", "objective-c", "c", ".net", "angularjs", "iphone")
)
WHERE row_num <= 2000
ORDER BY RAND()
```

#### SQL Query results

![image](12-save-sql-query-results.png)

Download as CSV or JSON might be unavailable

![image](13-download-JSON-or-CSV.png)

Alternatively, Create a Dataset, Save as Table and Export as CSV from that UI

![image](14-create-a-dataset-01.png)

Click on Create Dataset, and enter a suitable name for the dataset

![image](14-create-a-dataset-02.png)

Click on Save as Table, and enter the name of the created dataset

![image](15-copy-table.png)

Navigate to the dataset on the left side, expand it, select the table, and click on Preview 

![image](16-BigQuery-table-details.png)

**Create a Google Cloud Storage area i.e. a bucket**

https://console.cloud.google.com/storage

![image](17-google-cold-storage.png)

Click on Create Bucket

![image](18-cold-storage-create-bucket-01.png)

Select created bucket

![image](18-cold-storage-create-bucket-02.png)

Capture the gs:// URI from the console for the next step

![image](18-cold-storage-create-bucket-03.png)

```
gs://keras_so_tags_classifications
```

Return to https://bigquery.cloud.google.com/table/keras-so-tags-classification:keras_SO_tags_classification.results_20180913_190505?pli=1&tab=preview

**Export Table: Export the table as CSV**

Click on the Export Table button

![image](19-export-to-cold-storage-01.png)

WARNING: GCP in this instance might misinform that there has been an error while exporting the table but when you check the Job History the Job has been successfully executed (intermittent issue, not always reproducible):

![image](19-export-to-cold-storage-02.png)

**Retrieve exported CSV file**

Go to the https://console.cloud.google.com/storage/browser/keras_so_posts_classification?project=keras-so-tags-classification&folder&organizationId page 

![image](19-export-to-cold-storage-03.png)

Click on the file to download it to local machine.

**DELETE YOUR BUCKET ONCE DONE, AS IT COSTS TO STORE DATA ON GOOGLE CLOUD STORAGE (https://cloud.google.com/storage/pricing)**
