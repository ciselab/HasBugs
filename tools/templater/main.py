from jinja2 import Environment, FileSystemLoader    # For templating with jinja
import os                                           # For File/Directory Creation
import json                                         # For reading in the configurations
import argparse                                     # For handling a nice commandline interface

def run(datapoint_path,outputdir):
    """
    Does the following in order:
    - Check for specified files / directories, create or clean them if necessary
    - Read in the Datapoint
    - Create the Jinja Templates
    - Fill the Jinja Templates according to the datapoint
    - Place the .sh files and a copy of the datapoint in the output directory

    Any .patch files are NOT overwritten at this point, so it is safe to change the datapoint and rerun this script.
    :param datapoint:  Path to the datapoint.json specified in template
    :param outputdir: Path where to put the resolved references
    :return: ---
    """
    checkFiles(datapoint_path,outputdir)

    file_loader = FileSystemLoader('templates')
    env = Environment(loader=file_loader)

    cleanup_template = env.get_template('cleanup.sh.j2')
    tested_template = env.get_template('getTested.sh.j2')
    fixed_template = env.get_template('getFixed.sh.j2')
    buggy_template = env.get_template('getBuggy.sh.j2')

    with open(datapoint_path) as f:
        datapoint = json.load(f)
        #print("Found datapoint ",datapoint)

    cleanup_file = open(os.path.join(outputdir,"cleanup.sh"),"w")
    cleanup_content = cleanup_template.render(datapoint)
    cleanup_file.write(cleanup_content)
    cleanup_file.close()

    tested_file = open(os.path.join(outputdir,"getTested.sh"),"w")
    tested_content = tested_template.render(datapoint)
    tested_file.write(tested_content)
    tested_file.close()

    fixed_file = open(os.path.join(outputdir,"getFixed.sh"),"w")
    fixed_content = fixed_template.render(datapoint)
    fixed_file.write(fixed_content)
    fixed_file.close()

    buggy_file = open(os.path.join(outputdir,"getBuggy.sh"),"w")
    buggy_content = buggy_template.render(datapoint)
    buggy_file.write(buggy_content)
    buggy_file.close()

    datapoint_copy = open(os.path.join(outputdir,"datapoint.json"),"w")
    json.dump(datapoint,datapoint_copy)
    datapoint_copy.close()

    print("Successfully finished writing the templates - congratulations!")

def checkFiles(datapoint,outputdir):
    """
    Shortly checks if all the required files exist, throws errors otherwise
    """
    print("Checking for File existence...")
    failingExists(datapoint)
    if(os.path.exists(outputdir)):
        print("Output directory was found - parts be overwritten")
        if os.path.exists(os.path.join(outputdir,"cleanup.sh")):
            os.remove(os.path.join(outputdir,"cleanup.sh"))
        if os.path.exists(os.path.join(outputdir,"getTested.sh")):
            os.remove(os.path.join(outputdir,"getTested.sh"))
        if os.path.exists(os.path.join(outputdir,"getFixed.sh")):
            os.remove(os.path.join(outputdir,"getFixed.sh"))
        if os.path.exists(os.path.join(outputdir,"getBuggy.sh")):
            os.remove(os.path.join(outputdir,"getBuggy.sh"))
        if os.path.exists(os.path.join(outputdir,"datapoint.json")):
            os.remove(os.path.join(outputdir, "datapoint.json"))
    else:
        print("Output directory was not found - it will be created")
        os.makedirs(outputdir)
    failingExists("./templates")
    failingExists("./templates/cleanup.sh.j2")
    failingExists("./templates/getTested.sh.j2")
    failingExists("./templates/getFixed.sh.j2")
    failingExists("./templates/getBuggy.sh.j2")

def failingExists(path):
    if not os.path.exists(path):
        raise FileNotFoundError(path + " does not exist but is required")

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Creates a reference-point for the Rhodos dataset, starting from a datapoint.json')
    parser.add_argument('datapoint', metavar='dp', type=str, nargs=1,
                        help='Path to the datapoint.json used to fill the template - fill it with as many values as possible. Missing values will be defaulted.')
    parser.add_argument('directory', metavar='odir', type=str, nargs=1,
                        help='Path to the directory in which the created .sh files will be. When run from the repository, these should be ../../references/xxx/z')

    args = parser.parse_args()
    print("Running the Templater with args:")
    print(args)

    run(args.datapoint[0],args.directory[0])