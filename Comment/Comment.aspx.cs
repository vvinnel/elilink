using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Comment
{
    public partial class Comment : System.Web.UI.Page
    {

        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Comment"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            CommentsBind();
            lblError.Text = "";
        }

        private void CommentsBind()
        {
            SqlDataAdapter da = new SqlDataAdapter("spGetParentComment", con);
            DataSet ds = new DataSet();
            da.Fill(ds);
            GridViewComment.DataSource = ds;
            GridViewComment.DataBind();
        }
       
        protected void BtnCommentSend_Click(object sender, EventArgs e)
        {
            if ((TextBoxUser.Text.Equals("")))
            {
                lblError.Text = "Вы не ввели имя пользователя";
            }
            else
            {
                SqlCommand cmd = new SqlCommand("spCommentInsert", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Username", TextBoxUser.Text);
                cmd.Parameters.AddWithValue("@CommentMessage", txtComment.Text);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                CommentsBind();
            }
        }      

        protected void BtnReplyChild_Click(object sender, EventArgs e)
        {
            if ((TextBoxUser.Text.Equals("")))
            {
                lblError.Text = "Вы не ввели имя пользователя";
            }
            else
            {
                GridViewRow row = (sender as Button).NamingContainer as GridViewRow;
                Label lblParentCommentID = (Label)row.FindControl("lblParentCommentID");
                Label lblChildCommentID = (Label)row.FindControl("lblChildCommentID");
                TextBox txtCommentChild = (TextBox)row.FindControl("txtCommentReplyChild");
                SqlCommand cmd = new SqlCommand("spCommentReplyInsert", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Username", TextBoxUser.Text);
                cmd.Parameters.AddWithValue("@CommentMessage", txtCommentChild.Text);
                cmd.Parameters.AddWithValue("@ParentCommentID", lblParentCommentID.Text);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                CommentsBind();
            }
        }

        protected void GridViewComment_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            foreach (GridViewRow row in GridViewComment.Rows)
            {
                Label lblParentCommentID = (Label)row.FindControl("lblCommentID");
                GridView GridChild = (GridView)row.FindControl("GridViewChild");

                SqlCommand cmd = new SqlCommand("spGetParentCommentByParentCommentID", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ParentCommentID", lblParentCommentID.Text);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet dschild = new DataSet();
                da.Fill(dschild);
                if (dschild.Tables[0].Rows.Count > 0)
                {
                    GridChild.DataSource = dschild;
                    GridChild.DataBind();
                }
                else
                {
                    GridChild.DataSource = null;
                    GridChild.DataBind();
                }
            }
        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        protected void GridViewComment_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void BtnReplyParent_Click(object sender, EventArgs e)
        {
            if ((TextBoxUser.Text.Equals("")))
            {
                lblError.Text = "Вы не ввели имя пользователя";
            }
            else
            {
                GridViewRow row = (sender as Button).NamingContainer as GridViewRow;
                Label lblChildCommentID = (Label)row.FindControl("lblCommentID");
                TextBox txtCommentParent = (TextBox)row.FindControl("txtCommentReplyParent");
                SqlCommand cmd = new SqlCommand("spCommentReplyInsert", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Username", TextBoxUser.Text);
                cmd.Parameters.AddWithValue("@CommentMessage", txtCommentParent.Text);
                cmd.Parameters.AddWithValue("@ParentCommentID", lblChildCommentID.Text);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                CommentsBind();
            }
        }
    }
}