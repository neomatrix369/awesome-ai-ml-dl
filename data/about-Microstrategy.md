## Microstrategy

- Download desktop app from https://www.microstrategy.com/us/get-started/desktop (Mac or Windows)
- Install app and run it
- Create a new Dossier via the Create New Dossier button
- Add new dataset via the New data button (under Add Data)
  - File From Disk > Choose files
  - Select one or more files
  - Select Prepare Data
    - Data wrangling
      - Cleaning and wrangling
        - https://www.youtube.com/watch?v=m1ZMxSPGM6I
      - Wrangling 
        - https://www.youtube.com/watch?v=m1ZMxSPGM6I
        - https://www.youtube.com/watch?v=E6b6gLESXiY
  - Actions
    - Was able to do the following to the `haystack_http` dataset:
      - Fill the blank cells in the activity column with ‘null activity’
      - Split the date column into date and time columns
      - Extract just the domain name from the url column and create a new column from it
  - Limitations
    - Wasn’t able to label the url or domain column (needs sophisticated function work)
    - Wasn’t able to transform/extract from the date column into weekday or weekend labels
    - Wasn’t able to transform/extract from the time column into working hour/non-working hour labels

---

- [ ] [AI/ML/DL Library / Package / Framework: applicable]
- [ ] [Inexpensive crowd-sourced infrastructure sharing: applicable]
- [x] **[Data querying: manual / tools available]** 
- [ ] [Data analytics: manual / tools available] 
- [x] **[Data visualisation: manual / tools available]**
- [x] **[Data cleaning: manual]** 
- [x] **[Data validation: semi-automatic/manual]** 
- [x] **[Feature extraction: manual/tools available]** 
- [ ] [Model creation: available] 
- [ ] [Execute experiments: available]
- [ ] [Hyper parameter tuning: available] 
- [ ] [Model saving: available]

Back to [Programs and Tools](./programs-and-tools.md#programs-and-tools). <br/>
Back to [Data page](./README.md#data).