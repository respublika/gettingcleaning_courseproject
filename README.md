# Introducing run_analysis.R

From the explaining .txt files of the original datasets I found out that there are 8 separated file which I should have to get together:
- for train and test datasets: 3-3 files with feature variables and different IDs (for persons/subjects and activities)
- two other dataset with the name of the features and activities.

So, first, I read them into R, and explore what they contain.
Then from the 3-3 file I formed train and test datasets and finally added them together, with variable names from another file. I sorted this file by the two ID (subject and activity).
Because I needed only features with "mean" and "standard deviation" in their names, in the 4th part of my code I filtered out these variables.
Another requirement was to average (aggregate) all variable by activites and subjects, so in the 5th part I done this.
Finally I added activity names from a separated file, sort variable names, and drop some of them which weren't necessary (they only made by the aggregate function from the previous part).
I wrote out the final version of my tidy data with the name of "Samsung_tidy_data.txt".

