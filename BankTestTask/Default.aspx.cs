using System;
using System.Drawing;
using System.IO;
using System.Web.UI;
using System.Xml;
using System.Xml.Schema;
using System.Xml.Xsl;

namespace BankTestTask
{
    public partial class Default : Page
    {
        /// <summary>
        /// Specify the path on the server to save the uploaded file to
        /// </summary>
        private const string SavePath = "/Downloads/";

        /// <summary>
        /// Specify the path on the server to save the uploaded file to
        /// </summary>
        private const string GeneratedSavePath = "/Generated/";

        /// <summary>
        /// Specify the path on the server to uploaded file's schemas
        /// </summary>
        private const string SchemasPath = "/Schema/CardSchemas.xsd";

        /// <summary>
        /// Specify the path on the server to uploaded file's schemas
        /// </summary>
        private const string SchemastransformPath = "/Schema/TransformSchemas.xslt";

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// Download button click event handler
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void UploadBtn_Click(object sender, EventArgs e)
        {
            // Before attempting to save the file, verify that the FileUpload control contains a file
            if (FileUpload1.HasFile)
            {
                // Get the name of the file to upload
                string fileName = Server.HtmlEncode(FileUpload1.FileName);

                // Get the extension of the uploaded file
                string extension = Path.GetExtension(fileName);

                // Allow only files with .xml extension to be uploaded
                if (extension == ".xml")
                {
                    // Append the name of the file to upload to the path.
                    string savePath = Server.MapPath(SavePath + Guid.NewGuid() + "_" + fileName);

                    try
                    {
                        // Call the SaveAs method to save the uploaded file to the specified path
                        FileUpload1.SaveAs(savePath);

                        #region SectionToCheckDownloadedXMLFormat

                        XmlReaderSettings settings = new XmlReaderSettings();
                        settings.Schemas.Add(null, Server.MapPath(SchemasPath));
                        settings.ValidationType = ValidationType.Schema;

                        using (XmlReader reader = XmlReader.Create(savePath, settings))
                        {
                            XmlDocument document = new XmlDocument();
                            document.Load(reader);
                        }

                        #endregion

                        string generatedPath = GenerateHtml(savePath);

                        UploadStatusLabel.Text = File.ReadAllText(generatedPath);
                    }
                    // Catch incorrect schemas of downloaded XML exception
                    catch (XmlSchemaValidationException xmlSchemaValidationException)
                    {
#if DEBUG
                        Console.WriteLine(xmlSchemaValidationException);
#else
                        // Notify the user that their file wasn't successfully uploaded
                        UploadStatusLabel.Text = "Ваш файл не был загружен по причине неправильной схемы данных";
                        UploadStatusLabel.ForeColor = Color.Red;
#endif

                    }
                    catch (Exception exception)
                    {

#if DEBUG
                        Console.WriteLine(exception);
#else
                        // Notify the user that their file wasn't successfully uploaded
                        UploadStatusLabel.Text = "Ваш файл не был загружен по причине ошибки сервера. Мы работаем над устранением проблемы";
                        UploadStatusLabel.ForeColor = Color.Red;
#endif

                    }
                }
                else
                {
                    // Notify the user why their file was not uploaded
                    UploadStatusLabel.Text = "Ваш файл не был загружен по причине неправильного расширения. Должно быть .xml";
                    UploadStatusLabel.ForeColor = Color.Red;
                }
            }
        }

        private string GenerateHtml(string path)
        {
            XslCompiledTransform transform = new XslCompiledTransform();
            transform.Load(Server.MapPath(SchemastransformPath));
            string generatedPath = Server.MapPath(GeneratedSavePath + Guid.NewGuid() + ".html");
            transform.Transform(path, generatedPath);

            return generatedPath;
        }
    }
}