<%@ Page Title="" Language="C#" MasterPageFile="~/Master_teacher.master" %>
<%@ Import Namespace=" System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<script runat="server">
    SqlConnection con = new SqlConnection("Server=DESKTOP-G35UAO7\\MALIKSQL;Database=FILE_HOST;Integrated Security=sspi;");

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btn_add_Click(object sender, EventArgs e)
    {
        string sql = "insert into courses values (@id,@name)";
        SqlCommand cmd_add = new SqlCommand(sql,con);
        cmd_add.Parameters.AddWithValue("@id",txt_id.Text);
        cmd_add.Parameters.AddWithValue("@name", txt_name.Text);
        con.Open();
        cmd_add.ExecuteNonQuery();
        con.Close();
        lbl_message.Text="Läggs till med framgång";
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style4 {
            width: 100%;
        }
        .auto-style5 {
            width: 186px;
        }
        .auto-style6 {
            font-weight: bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="auto-style4">
        <tr>
            <td class="auto-style5"><strong>
                <asp:Label ID="Label1" runat="server" Font-Names="Tahoma" Text="Ämne numret"></asp:Label>
                </strong></td>
            <td>
                <asp:TextBox ID="txt_id" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style5"><strong>
                <asp:Label ID="Label2" runat="server" Font-Names="Tahoma" Text="Ämne namnet"></asp:Label>
                </strong></td>
            <td>
                <asp:TextBox ID="txt_name" runat="server" Width="250px"></asp:TextBox>
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
                <strong>
                <asp:Button ID="btn_add" runat="server" OnClick="btn_add_Click" Text="lägga till ämne" CssClass="auto-style6" />
                </strong>
            </td>
        </tr>
        <tr>
            <td class="auto-style5">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>

