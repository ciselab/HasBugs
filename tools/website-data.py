#!/usr/bin/env python3

""" 
This script iterates over all datapoints and creates the 3 files necessary for the website: 
- a .md file per datapoint
- the renamed datapoint (name as per id)
- the merged dataset from the datapoints
"""

import os
import json
import shutil
import datetime

reference_directory = '../references'
output_directory = "./website-output"

markdown_template = """
+++
author = "Ciselab / Leonhard Applis"
title = "%s"
date = "%s"

id = "%s"
categories = %s
tags = %s

description = "%s"
+++
"""

def fill_markdown_template(bug_id:str, categories:[str], tags:[str],description:str) -> str:
    converted_categories:str = "[" + (",").join(categories) + "]"
    converted_tags:str = "[" + (",").join(tags) + "]"

    current_date = str(datetime.datetime.now())[:10]

    return markdown_template % (bug_id,current_date,bug_id,categories,tags,description)

def make_or_reset_output_folder()->None:
    os.makedirs(os.path.dirname(output_directory), exist_ok=True)
    markdown_path = os.path.join(output_directory,"markdowns")
    os.makedirs(markdown_path, exist_ok=True)
    json_path = os.path.join(output_directory,"jsons")
    os.makedirs(json_path, exist_ok=True)
        
    for f in os.listdir(json_path):
        os.remove(os.path.join(json_path, f))
        
    for f in os.listdir(markdown_path):
        os.remove(os.path.join(markdown_path, f))

def main() -> None:
    #print(fill_markdown_template("a","b","c",["d","d2"],["e","e2"],"f"))
    make_or_reset_output_folder()
    all_datapoints = []

    for root, dirs, files in os.walk(reference_directory):
        # We have some invalid datapoints, do not add them.
        if "invalid" in root:
            continue
        path = root.split(os.sep)
        for file in files:
            if "datapoint.json" in file:
                datapoint_path = (os.path.join(root,file))
                datapoint = json.load(open(datapoint_path))
                all_datapoints.append(datapoint)
                # Copy JSON
                json_output = os.path.join(output_directory,"jsons",datapoint["id"]+".json")
                shutil.copy(datapoint_path, json_output)
                # Make Markdown
                md_output = os.path.join(output_directory,"markdowns",datapoint["id"]+".md")
                with open(md_output, "w+") as md_file:
                    md_content = fill_markdown_template(datapoint["id"],datapoint["categories"],datapoint["testframeworks"],datapoint["description"])
                    md_file.write(md_content)
    # Make the merged dataset.json
    dataset = {}
    dataset["datapoints"]=all_datapoints
    dataset["creationdate"]=str(datetime.datetime.now())[:10]

    dataset_path = os.path.join(output_directory,"dataset.json")
    with open(dataset_path,"w+") as dataset_file:
        json.dump(dataset,dataset_file)
        

if __name__ == '__main__':
    main()