# St. Louis Lab Assignment - Sept. 24-25, 2025

## Access Points and Switches Serial Numbers
{{ read_csv('data/lab_assignment.csv',colalign=("left","center","center","center"), usecols=['Email','AP#1','AP#2','Switch']) }}

## Student and Pod Assignment
{{ read_csv('data/lab_assignment.csv',colalign=("left","center","center"), usecols=['Email','Lab Assignment','Student Pod #']) }}
