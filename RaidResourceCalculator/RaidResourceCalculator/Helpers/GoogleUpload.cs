using System;
using Google.Apis.Drive.v3;
using Google.Apis.Auth.OAuth2;
using System.Threading;
using Google.Apis.Util.Store;
using Google.Apis.Services;
using Google.Apis.Drive.v3.Data;
using System.Collections.Generic;
using Google.Apis.Upload;

namespace RaidResourceCalculator.Helpers
{
    public class GoogleUpload:ObjectModel
    {
        private double uploadStatus;

        public double UploadStatus
        {
            get { return uploadStatus; }
            set {
                uploadStatus = value;
                OnPropertyChanged(nameof(UploadStatus));
            }
        }


        // tries to figure out the mime type of the file.
        private static string GetMimeType(string fileName)
        {
            string mimeType = "application/unknown";
            string ext = System.IO.Path.GetExtension(fileName).ToLower();
            Microsoft.Win32.RegistryKey regKey = Microsoft.Win32.Registry.ClassesRoot.OpenSubKey(ext);
            if (regKey != null && regKey.GetValue("Content Type") != null)
                mimeType = regKey.GetValue("Content Type").ToString();
            return mimeType;
        }

        public UserCredential GetCredentials(String clientId, String clientSecret)
        {
            //Scopes for use with the Google Drive API
            string[] scopes = new string[] { DriveService.Scope.Drive,
                                 DriveService.Scope.DriveFile};
            var credential = GoogleWebAuthorizationBroker.AuthorizeAsync(new ClientSecrets
            {
                ClientId = clientId,
                ClientSecret = clientSecret
            },
                                                                        scopes,
                                                                        Environment.UserName, //TODO: EDIT
                                                                        CancellationToken.None,
                                                                        new FileDataStore("Daimto.GoogleDrive.Auth.Store")).Result; //TODO: Edit
            return credential;
        }

        public DriveService Authorize(UserCredential credentials)
        {
            DriveService service = new DriveService(new BaseClientService.Initializer()
            {
                HttpClientInitializer = credentials,
                ApplicationName = "MyAppName",

            });
            service.HttpClient.Timeout = TimeSpan.FromMinutes(100);
            return service;
        }

        public static File Upload(DriveService service, String uploadFile, String parent, String fileId, String description)
        {
            if (System.IO.File.Exists(uploadFile))
            {
                Google.Apis.Drive.v3.Data.File body = new Google.Apis.Drive.v3.Data.File();
                body.Name = System.IO.Path.GetFileName(uploadFile);
                body.Description = description;
                body.MimeType = GetMimeType(uploadFile);
                // body.Parents = new List<string> { _parent };// UN comment if you want to upload to a folder(ID of parent folder need to be send as paramter in above method)
                byte[] byteArray = System.IO.File.ReadAllBytes(uploadFile);
                System.IO.MemoryStream stream = new System.IO.MemoryStream(byteArray);
                try
                {
                    FilesResource.UpdateMediaUpload request = service.Files.Update(body,fileId, stream, GetMimeType(uploadFile));
                    request.SupportsTeamDrives = true;
                    // You can bind event handler with progress changed event and response recieved(completed event)
                    request.ProgressChanged += Request_ProgressChanged;
                    request.ResponseReceived += Request_ResponseReceived;
                    request.Upload();
                    return request.ResponseBody;
                }
                catch (Exception e)
                {
                    return null;
                }
            }
            else
            {
                return null;
            }
        }

        private static void Request_ResponseReceived(File obj)
        {
            throw new NotImplementedException();
        }

        private static void Request_ProgressChanged(IUploadProgress obj)
        {
            throw new NotImplementedException();
        }
    }
}
