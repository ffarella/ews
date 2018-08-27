import os
import urllib2

def replace_filepath(file_path, ews_drives_path=None):  
   
    if ews_drives_path is None:
        ews_drives_path = os.environ.get("EWS_DRIVES", None)
    file_path = urllib2.unquote(file_path.decode("utf-8"))       
    if file_path.startswith("file://"):
        file_path = file_path[7:]    
    while "\\" in file_path:
        file_path = file_path.replace("\\", "/")
    if os.name != "posix":
        return file_path
    for drive_letter in map(chr, range(97,123)):
        if file_path.lower().startswith(drive_letter+":/"):
            file_path = u'{ews_drives_path}/{drive_letter}/{file_path}'.format(
                ews_drives_path=ews_drives_path, 
                drive_letter=drive_letter, 
                file_path=file_path[3:] 
            )
    return file_path