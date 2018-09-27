<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Comment.aspx.cs" EnableEventValidation="false" Inherits="Comment.Comment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>    
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script type="text/javascript">
        //GridView Comment 
        var prevComment = [];
        function showReply(n) {
            $("#divReply" + n).show();
            return false;
        }
        function closeReply(n) {
            $("#divReply" + n).hide();
            return false;
        }
    </script>
    <style type="text/css">
        .link {
            text-decoration:none;
            color:#808080;
        }
            .link:hover {
                color:#dddddd;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Article<br />
            <asp:TextBox ID="TextBoxArticle" runat="server" Height="77px" Width="482px"></asp:TextBox>
        </div>
        <div style="height: 46px">

            UserName<br />
            <asp:TextBox ID="TextBoxUser" runat="server" OnTextChanged="TextBox1_TextChanged" Width="203px"></asp:TextBox>

            <asp:Label ID="lblError" runat="server"></asp:Label>

        </div>
    <div>
        &nbsp;Message<br />
        <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" Width="560px" Height="60px"></asp:TextBox>
        <br />
        <asp:Button ID="BtnCommentSend" runat="server" Text="Send" OnClick="BtnCommentSend_Click" />
        <br />
        </div>
        <asp:GridView ID="GridViewComment" runat="server" AutoGenerateColumns="false" BorderWidth="0" Width="50%" OnRowDataBound="GridViewComment_RowDataBound">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                    <div style="width:100%;">
                                    <table style="margin:3px 5px; width:100%;">
                                        <tr>                                           
                                            <td style="padding:0px 5px; text-align:left; vertical-align:top;">
                                              <asp:Label ID="lblCommentID" runat="server" Visible="false" Text='<% #Eval("CommentID") %>'></asp:Label>
                                             Пользователь <asp:Label ID="LblUser" runat="server" Text='<% #Eval("Username") %>'></asp:Label>
                                             время коментария <asp:Label ID="LblDateComment" runat="server" Text='<% #Eval("CommentDate") %>'></asp:Label>
                                              <div>
                                                  <asp:Label ID="lblCommentMessage" runat="server" Text='<% #Eval("CommentMessage") %>'></asp:Label><br />
                                              </div>
                                               <a class="link" id='lnkReplyParent<%# Eval("CommentID") %>' href="javascript:void(0)" onclick="show(<%# Eval("CommentID") %>); return false;">Reply</a>&nbsp;
                                               <a class="link" id="lnkCancel" href="javascript:void(0)" onclick="closeReply(<%# Eval("CommentID") %>); return false;">Cancel</a>
                                               <div id='divReply<%# Eval("CommentID") %>' style="display:block; margin-top:5px;">
                                                    <asp:TextBox ID="txtCommentReplyParent" runat="server" TextMode="MultiLine" Width="560px" Height="60px"></asp:TextBox>
                                                    <asp:Button ID="BtnReplyParent" runat="server" Text="Reply" style="float:right;margin:5px;" OnClick="BtnReplyParent_Click" />
                                               </div>
                                            </td>
                                        </tr>
                                     </table>
                     </div>
                        <div style="padding-left:75px;">
                            <asp:GridView ID="GridViewChild" runat="server" AutoGenerateColumns="false" BorderWidth="0" Width="50%">
                                 <Columns>
                                  <asp:TemplateField>
                                    <ItemTemplate>
                                        <div style="width:100%;">
                                    <table style="margin:3px 5px; width:150%;">
                                        <tr>                                           
                                            <td style="padding:0px 5px; text-align:left; vertical-align:top;">
                                              <asp:Label ID="lblParentCommentID" runat="server" Visible="false" Text='<% #Eval("ParentCommentID") %>'></asp:Label>
                                              <asp:Label ID="lblChildCommentID" runat="server" Visible="false" Text='<% #Eval("ChildCommentID") %>'></asp:Label>
                                             Пользователь <asp:Label ID="LblUser" runat="server" Text='<% #Eval("ChildUsername") %>'></asp:Label>
                                             время коментария  <asp:Label ID="LblDateComment" runat="server" Text='<% #Eval("ChildCommentDate") %>'></asp:Label>                                             
                                             <div> <asp:Label ID="lblChildCommentMessage" runat="server" Text='<% #Eval("ChildCommentMessage") %>'></asp:Label><br />
                                             </div>
                                                 <a class="link" id='lnkReplyChild<%# Eval("ChildCommentID") %>' href="javascript:void(0)" onclick="showReply(<%# Eval("ChildCommentID") %>); return false;">Reply</a>&nbsp;
                                               <a class="link" id="lnkCancel" href="javascript:void(0)" onclick="closeReply(<%# Eval("ChildCommentID") %>); return false;">Cancel</a>
                                               <div id='divReply<%# Eval("ChildCommentID") %>' style="display:none; margin-top:5px;">
                                                    <asp:TextBox ID="txtCommentReplyChild" runat="server" TextMode="MultiLine" Width="560px" Height="60px"></asp:TextBox>
                                                    <asp:Button ID="BtnReplyChild" runat="server" Text="Reply" style="float:right;margin:5px;" OnClick="BtnReplyChild_Click" />
                                               </div>  
                                            </td>
                                        </tr>
                                     </table>
                     </div>
                                    </ItemTemplate>
                                  </asp:TemplateField>
                                 </Columns>
                            </asp:GridView>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </form>
    </body>
</html>
