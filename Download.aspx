
<%@ Page Title="" Language="C#" MasterPageFile="~/master_student.master" %>
<%@ Import Namespace=" System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>

<script runat="server">
    SqlConnection con = new SqlConnection("Server=DESKTOP-G35UAO7\\MALIKSQL;Database=FILE_HOST;Integrated Security=sspi;");

    void fill_files()
    {
        string sql = "select *,(select course_name from courses where course_id=files.course_id) as course_name from files order by upload_date desc";
        SqlDataAdapter da = new SqlDataAdapter(sql, con);
        DataTable dt = new DataTable();
        da.Fill(dt);
        grid_files.DataSource = dt;
        grid_files.DataBind();


    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            fill_files();
        }
    }

    protected void grid_files_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "down")
        {
            int j = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = grid_files.Rows[j];
            Label file = (Label)row.FindControl("lbl_path");

            //to account how many a file is downloaded

            string sql = "";
            sql = "update files set downloads=downloads+1 where file_id=@file";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@file", row.Cells[0].Text);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            //----------- 
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + file.Text);
            Response.ContentType = "application/octet-stream";
            Response.TransmitFile(file.Text);
            Response.End();
        }
    }

    protected void grid_files_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grid_files.PageIndex = e.NewPageIndex;
        fill_files();
    }

    //To calculate the file size

    protected void grid_files_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label file = (Label)e.Row.FindControl("lbl_path");
            System.IO.FileInfo y = new System.IO.FileInfo(Server.MapPath("\\") + file.Text.Replace("~", ""));
            decimal size = Convert.ToDecimal(y.Length / 1024);

            if (size > 1024)
            {
                size = size / 1024;
                e.Row.Cells[5].Text = size.ToString("f1") + "Mb";
            }
            else
            {
                e.Row.Cells[5].Text = size.ToString("f1") + "Kb";
            }
            
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style4 {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="auto-style4">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style3">
                <asp:GridView ID="grid_files" runat="server" AutoGenerateColumns="False" OnRowCommand="grid_files_RowCommand" AllowPaging="True" OnPageIndexChanging="grid_files_PageIndexChanging" PageSize="5" OnRowDataBound="grid_files_RowDataBound">
                    <Columns>
                        <asp:BoundField DataField="file_id" HeaderText="Fil numer" />
                        <asp:BoundField DataField="title" HeaderText="Fil biskrivning">
                        <ItemStyle Width="220px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="upload_date" HeaderText="Fil datum" />
                        <asp:BoundField DataField="course_name" HeaderText="Kurs namn" />
                        <asp:TemplateField HeaderText="Fil bana" Visible="False">
                            <ItemTemplate>
                                <asp:Label ID="lbl_path" runat="server" Text='<%# Bind("path") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Fil storlek" />
                        <asp:ButtonField ButtonType="Button" CommandName="down" Text="Lada ner" />
                    </Columns>
                    <PagerStyle HorizontalAlign="Center" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>

