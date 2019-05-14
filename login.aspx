<%@ Page Language="C#" %>
<%@ Import Namespace=" System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>

<!DOCTYPE html>

<script runat="server">
    SqlConnection con = new SqlConnection("Server=DESKTOP-G35UAO7\\MALIKSQL;Database=FILE_HOST;Integrated Security=sspi;");

    protected void btn_login_Click(object sender, EventArgs e)
    {
        string sql = "select * from users where email=@email and pass=@pass";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@email", txt_email.Text);
        cmd.Parameters.AddWithValue("@pass", txt_password.Text);
        SqlDataReader r;
        con.Open();
        r = cmd.ExecuteReader();
        if (r.HasRows)
        {
            string user_type = "";
            while (r.Read())
            {
                Session["user"] = r["user_id"].ToString();
                user_type = r["user_type"].ToString();
            }
            con.Close();

            if (user_type =="1")
            {
                Response.Redirect("Download.aspx");
            }
           else if (user_type =="2")
            {
                Response.Redirect("upload.aspx");
            }
        }
        else
        {
            lbl_error.Text = "error";
        }
        con.Close();
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            text-align: center;
        }
        .auto-style2 {
            width: 500px;
            border-collapse: collapse;
        }
        .auto-style7 {
            width: 120px;
            text-align: left;
            height: 31px;
        }
        .auto-style9 {
            width: 120px;
            height: 29px;
        }
        .auto-style11 {
            height: 31px;
            text-align: left;
        }
        .auto-style12 {
            height: 29px;
            text-align: left;
        }
        .auto-style13 {
            font-weight: bold;
        }
    </style>
</head>
<body style="background-color:white; margin-top:0px; margin-left:0px; margin-right:0px">
    <form id="form1" runat="server">
        <div id="header" style="width:100%;height:120px;background-color:#00ffff"; class="auto-style1">
        <asp:Image  ID="Image1" runat="server" ImageUrl="~/imeges/banner.png" />
            <table align="center" class="auto-style2">
                <tr>
                    <td class="auto-style7"><strong>
                        <asp:Label ID="lbl_email" runat="server" Font-Names="Tahoma" Text="E-post"></asp:Label>
                        </strong></td>
                    <td class="auto-style11">
                        <asp:TextBox ID="txt_email" runat="server" TextMode="Email" Width="250px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style7">
                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Tahoma" Text="Lösenord"></asp:Label>
                    </td>
                    <td class="auto-style11">
                        <asp:TextBox ID="txt_password" runat="server" TextMode="Password" Width="250px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style9"></td>
                    <td class="auto-style12">
                        <asp:Label ID="lbl_error" runat="server" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style9"></td>
                    <td class="auto-style12"><strong>
                        <asp:Button ID="btn_login" runat="server" CssClass="auto-style13" Text="Logga in" OnClick="btn_login_Click" />
                        </strong></td>
                </tr>
            </table>
        </div>
    </form>

</body>
</html>
