from jinja2 import Environment, FileSystemLoader    # For templating with jinja
import os                                           # For File/Directory Creation
import json                                         # For reading in the configurations
import argparse                                     # For handling a nice commandline interface

def run(datapoint,outputdir):
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
    print("Hello World")
    checkFiles(datapoint,outputdir)

def checkFiles(datapoint,outputdir):
    """
    Shortly checks if all the required files exist, throws errors otherwise
    """
    print("Checking for File existance...")
    os.path.isfile(datapoint)
    if(os.path.exists(outputdir)):
        print("Output directory was found - parts be overwritten")
        os.remove(os.path.join(outputdir,"cleanup.sh"))
        os.remove(os.path.join(outputdir,"getTested.sh"))
        os.remove(os.path.join(outputdir,"getFixed.sh"))
        os.remove(os.path.join(outputdir,"getBuggy.sh"))
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

    print(args)

    run(args.datapoint[0],args.directory[0])