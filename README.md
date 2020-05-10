---
title: "README"
author: "J Gregg"
date: "10/05/2020"
output: html_document
---

## Getting and Cleaning Data

This folder contains the run_analysis.R script which will take testing and training data from the UCI HAR Dataset. 

Data has been selected based on measurements that have had mean or standard deviations calculated on them. The subjectid and activity description has been added and test and training data combined into a single data frame

This data frame has then been grouped by subjectid and activity and summarised to give mean of each column based on this grouping.

Information on column names can be found and measurements can be found in the CodeBook.txt and names.txt documents
