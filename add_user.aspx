<%@ Page Title="" Language="C#" MasterPageFile="~/Master_admin.master" %>
<%@ Import Namespace=" System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>

<script runat="server">
    SqlConnection con = new SqlConnection("Server=DESKTOP-G35UAO7\\MALIKSQL;Database=FILE_HOST;Integrated Security=sspi;");

    protected void btm_save_Click(object sender, EventArgs e)
    {
        Random rnd = new Random();
        txt_password.Text = rnd.Next(1000, 10000000).ToString();
        string sql = "insert into users (user_name,email,pass,user_type) values (@name,@email,@pass,@type)";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@name", txt_name.Text);
        cmd.Parameters.AddWithValue("@email", txt_email.Text);
        cmd.Parameters.AddWithValue("@pass", txt_password.Text);
        cmd.Parameters.AddWithValue("@type", drob_user_type.SelectedValue);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
        lbl_message.Text = "Läggs till användaren med framgång";
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style4 {
            width: 100%;
        }
        .auto-style5 {
            width: 208px;
        }
        .auto-style6 {
            width: 208px;
            height: 33px;
            margin-left: 10px;
            margin-right: 10px;
        }
        .auto-style7 {
            height: 33px;
        }
        .auto-style8 {
            width: 208px;
            height: 33px;
        }
        .auto-style9 {
            font-weight: bold;
            font-size: medium;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="auto-style4">
        <tr>
            <td class="auto-style6"><strong>
                <asp:Label ID="user_nam" runat="server" Font-Bold="True" Font-Names="Tahoma" Text="Användare namn"></asp:Label>
                </strong></td>
            <td class="auto-style7">
                <asp:TextBox ID="txt_name" runat="server" Width="300px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style8"><strong>
                <asp:Label ID="email" runat="server" Font-Bold="True" Font-Names="Tahoma" Text="E-post"></asp:Label>
                </strong></td>
            <td class="auto-style7">
                <asp:TextBox ID="txt_email" runat="server" Width="250px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style5"><strong>
                <asp:Label ID="password" runat="server" Font-Bold="True" Font-Names="Tahoma" Text="Lösenord"></asp:Label>
                </strong></td>
            <td>
                <asp:TextBox ID="txt_password" runat="server" Width="250px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style5"><strong>
                <asp:Label ID="user_type" runat="server" Font-Bold="True" Font-Names="Tahoma" Text="Användartyp"></asp:Label>
                </strong></td>
            <td>
                <asp:DropDownList ID="drob_user_type" runat="server" Width="132px">
                    <asp:ListItem Value="1">Elev</asp:ListItem>
                    <asp:ListItem Value="2">Lärare</asp:ListItem>
                    <asp:ListItem Value="3">Webbadministratör</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="auto-style5">&nbsp;</td>
            <td>
                <asp:Label ID="lbl_message" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style6">&nbsp;</td>
            <td><strong>
                <asp:Button ID="btm_save" runat="server" CssClass="auto-style9" OnClick="btm_save_Click" Text="Spara användare" />
                </strong></td>
        </tr>
    </table>
</asp:Content>

