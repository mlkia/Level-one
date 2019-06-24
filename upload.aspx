<%@ Page Title="" Language="C#" MasterPageFile="~/Master_teacher.master" %>
<%@ Import Namespace=" System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Net.Mail" %>
<script runat="server">
    SqlConnection con = new SqlConnection("Server=DESKTOP-G35UAO7\\MALIKSQL;Database=FILE_HOST;Integrated Security=sspi;");
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack)
        {
            string sql = "select * from courses";
            SqlDataAdapter da = new SqlDataAdapter(sql, con);
            DataTable dt_courses = new DataTable();
            da.Fill(dt_courses);
            drop_courses.DataSource = dt_courses;
            drop_courses.DataTextField = "course_name";
            drop_courses.DataValueField = "course_id";
            drop_courses.DataBind();
        }
    }


    protected void btn_upload_Click(object sender, EventArgs e)
    {
        if ( Session["user"] == null)
        {
            Response.Redirect("login.aspx");
        }


        if (myfileupload.HasFiles)
        {
            string ext = System.IO.Path.GetExtension(myfileupload.FileName);



            //if (myfileupload.PostedFile.ContentLength > 9000 )
            //{
            //    lbl_message.Text = "The file has to be less";
            //    return;
            //}

            if (ext !=".pdf" && ext!=".docx" && ext!=".mp4" && ext!=".jpg")
            {
                lbl_message.Text = "Error file";
                return;
            }



            string file_name = "";
            file_name = file_name + Session["user"].ToString() + "_";
            file_name = file_name + DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString();
            file_name += DateTime.Now.Day.ToString();
            file_name += DateTime.Now.Hour.ToString();
            file_name += DateTime.Now.Minute.ToString();
            file_name += DateTime.Now.Second.ToString();
            myfileupload.SaveAs(Server.MapPath("files") + "\\" + file_name + ext);
            string path = "~\\files\\" + file_name + ext;
            string sql = "insert into files (title,upload_date,course_id,user_id,path,downloads)";
            sql = sql + "values(@title,@dat,@course,@user,@path,@count)";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@title", txt_title.Text);
            cmd.Parameters.AddWithValue("@dat", DateTime.Now);
            cmd.Parameters.AddWithValue("@course", drop_courses.SelectedValue);
            cmd.Parameters.AddWithValue("@user", Session["user"].ToString());
            cmd.Parameters.AddWithValue("@path", path);
            cmd.Parameters.AddWithValue("@count", 0);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            //send email
            SmtpClient client = new SmtpClient("smtp.gmail.com",587);
            client.EnableSsl = true;
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.UseDefaultCredentials = false;
            client.Credentials = new NetworkCredential("mlk.2plus@gmail.com", "*********");
            MailMessage message = new MailMessage(to:"mlk.820g@gmail.com",from:"mlk.2plus@gmail.com",subject:"ne ny",body:"ladda en ny fil");
            message.To.Add("mlk.820g@gmail.com");
            message.From = new MailAddress("mlk.2plus@gmail.com");
            message.Subject = "En ny fil";
            message.Body = "Ladda up en ny fil";
            client.Send(message);
            //Response.Write("Message has been sent successfully");
            message.IsBodyHtml = true;

            lbl_message.Text = "bra";
        }
        else
        {
            lbl_message.Text = "error";
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style4 {
            width: 100%;
            border-collapse: collapse;
        }
        .auto-style5 {
            width: 194px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="auto-style4">
        <tr>
            <td class="auto-style5"><strong>
                <asp:Label ID="Label1" runat="server" Text="Fil beskrivning"></asp:Label>
                </strong></td>
            <td>
                <asp:TextBox ID="txt_title" runat="server" Width="400px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style5"><strong>
                <asp:Label ID="Label2" runat="server" Text="Ämne namnet"></asp:Label>
                </strong></td>
            <td>
                <asp:DropDownList ID="drop_courses" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="auto-style5"><strong>
                <asp:Label ID="Label3" runat="server" Text="Fil platsen"></asp:Label>
                </strong></td>
            <td>
                <asp:FileUpload ID="myfileupload" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="auto-style5">&nbsp;</td>
            <td>
                <asp:Label ID="lbl_message" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style5">&nbsp;</td>
            <td>
                <asp:Button ID="btn_upload" runat="server" Text="ladda up" OnClick="btn_upload_Click" />
            </td>
        </tr>
    </table>
</asp:Content>

