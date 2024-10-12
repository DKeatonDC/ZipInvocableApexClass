public class ZipInvocable {
public class ZipVariable{
    @InvocableVariable(label='Files To Zip' description='A collection of content documents to zip')
public List<ContentVersion> filesToZip;
}
@InvocableMethod
public static List<ContentVersion> ZipAttachments(List<ZipVariable> contentVersionList){
    List <ContentVersion> contentVersionsToReturn = new List<ContentVersion>();
    //The completed zip archive will be added to this empty list
    Compression.ZipWriter writer = new Compression.ZipWriter();
    //ZipWriter is the method used to create the Zip archive.
datetime d = system.now();
string dateTimeVariable = d.format('yyyy-MM-ddh:mma');
    for(ZipVariable contentVersionSingle: contentVersionList){
list<ContentVersion> versionsFromFlow = contentVersionSingle.filesToZip;        
for(ContentVersion cv: versionsFromFlow){
    writer.AddEntry(cv.Title, cv.VersionData);
        }
        //Adds all content versions from the flow to the ZipWriter
        blob newZipArchive = writer.getArchive();
        //Assigns the zipped data to a 'blob' that will be used to make the content version for the system.        
        ContentVersion zipContentVersion = new ContentVersion(
VersionData = newZipArchive,
Title = 'ArchivedFiles'+ dateTimeVariable +'.zip',
Description = 'Files zipped from flow',
PathOnClient = '/ArchivedFiles' + dateTimeVariable + '.zip');  
contentVersionsToReturn.add(zipContentVersion);  
}
return contentVersionsToReturn;
} 
}