<%@ Page Title="" Language="C#" MasterPageFile="~/Master_teacher.master" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Net.Mail" %>

<script runat="server">

    protected void snd_mail_Click(object sender, EventArgs e)
    {
        try
        {
            SmtpClient client = new SmtpClient("smtp.gmail.com",587);
            client.EnableSsl = true;
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.UseDefaultCredentials = false;
            client.Credentials = new NetworkCredential("mlk.2plus@gmail.com", "07708485250");
            MailMessage message = new MailMessage(to:"mlk.820g@gmail.com",from:"mlk.2plus@gmail.com",subject:"ne ny",body:"ladda en ny fil");
            message.To.Add("mlk.820g@gmail.com");
            message.From = new MailAddress("mlk.2plus@gmail.com");
            message.Subject = "Test";
            message.Body = "Hej!";
            client.Send(message);
            Response.Write("Message has been sent successfully");
            message.IsBodyHtml = true;


        }
        catch (Exception ex)
        {
            Response.Write("couldnot send Email" + ex.Message);
        }

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Button ID="snd_mail" runat="server" EnableTheming="True" Font-Bold="True" OnClick="snd_mail_Click" Text="Send Email" />
</asp:Content>

