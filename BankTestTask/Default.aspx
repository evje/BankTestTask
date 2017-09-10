<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BankTestTask.Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function ResetFile() {
            document.getElementById("MainContent_FileUpload1").value = null;
        }

        function CheckFile(event) {
            var fileValue = document.getElementById("MainContent_FileUpload1").value;
            if (fileValue === '') {
                event.preventDefault();
            }
        }
    </script>
    <div class="jumbotron">
        <p class="lead">Выберите файл импорта *.xml на своем локальном диске и нажмите кнопку "Отправить".</p>
        
        <div class="lead">
            <asp:FileUpload id="FileUpload1" runat="server"></asp:FileUpload>
            
            <p style="text-align: right;">
                <button id="ResetBtn" class="btn btn-primary btn-warning" type="button" onclick="ResetFile();">Отмена</button>
                <asp:Button id="UploadBtn" Text="Отправить" OnClick="UploadBtn_Click" OnClientClick="CheckFile(event);" runat="server" CssClass="btn btn-primary btn-warning"></asp:Button>
            </p>
            

            <hr />

            <asp:Label id="UploadStatusLabel" runat="server"></asp:Label>     
        </div>
    </div>
</asp:Content>
