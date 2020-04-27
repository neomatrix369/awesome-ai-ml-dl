## Tableau Prep

- Download desktop app from https://www.tableau.com/products/prep (Mac or Windows) or the public version at https://public.tableau.com/en-us/s/
- Install app and run it
- Add new dataset via the (+) sign next to Connections
  - File From Disk > Choose files
  - Select one or more files
  - Once data is loaded click on the (+) sign next to the haystack_http icon on the top and select Add Step
  - Select the column you want to amend, select Edit value, change the value and click on enter
  - Actions
    - Was able to do the following to the `haystack_http` dataset (quite easily):
      - Fill the blank cells in the activity column with ‘null activity’
      - Split the date column into date and time columns
      - Extract just the domain name from the url column and create a new column from it
    - There is a good way to transform columns in Tableau into new types
  - Limitations
    - Wasn’t able to label the url or domain column (needs sophisticated function work)
    - Was able to transform/extract from the date column into weekday or weekend labels with some effort - had to create a calculated field and then apply an if condition to it
    - Was able to transform/extract from the time column into working hour/non-working hour labels - had to create a calculated field and then apply an if condition to it

---

- [ ] [AI/ML/DL Library / Package / Framework: applicable]
- [ ] [Inexpensive crowd-sourced infrastructure sharing: applicable]
- [x] **[Data querying: manual / tools available]** 
- [ ] [Data analytics: manual / tools available] 
- [x] **[Data visualisation: manual / tools available]**
- [x] **[Data cleaning: manual]** 
- [x] **[Data validation: sem-automatic/manual]** 
- [x] **[Feature extraction: manual/tools available]** 
- [ ] [Model creation: does not] 
- [ ] [Execute experiments: available]
- [ ] [Hyper parameter tuning: does not] 
- [ ] [Model saving: does not]

Back to [Programs and Tools](./programs-and-tools.md#programs-and-tools). <br/>
Back to [Data page](./README.md#data).