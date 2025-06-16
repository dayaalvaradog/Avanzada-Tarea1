<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Avanzada_Tarea1.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Suscribirse al boletín</title>
    <script src="Scripts/jquery-3.7.0.min.js"></script>
    <link href="Content/Site.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="form-container">
                    <h2>Suscribirse al boletín</h2>
                    <div class="form-group">
                        <label for="txtName">Nombre:</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
                        <span id="nameError" class="error-message">El nombre es obligatorio.</span>
                    </div>
                    <div class="form-group">
                        <label for="txtEmail">Correo Electrónico:</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                        <span id="emailError" class="error-message">El correo electrónico es obligatorio y debe ser válido.</span>
                    </div>
                    <asp:Button ID="btnSubmit" runat="server" Text="Suscribirse" OnClick="btnSubmit_Click" />
                </div>

                <div class="data-table-container">
                    <h3>Datos Registrados</h3>
                    <asp:Literal ID="litData" runat="server"></asp:Literal>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>

    <script>
        $(document).ready(function () {
            // Validación del formulario con jQuery
            $('#<%= btnSubmit.ClientID %>').click(function (e) {
                var isValid = true;

                // Validar Nombre
                var name = $('#<%= txtName.ClientID %>').val().trim();
                if (name === '') {
                    $('#nameError').show();
                    isValid = false;
                } else {
                    $('#nameError').hide();
                }

                // Validar Correo Electrónico
                var email = $('#<%= txtEmail.ClientID %>').val().trim();
                var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (email === '' || !emailRegex.test(email)) {
                    $('#emailError').show();
                    isValid = false;
                } else {
                    $('#emailError').hide();
                }

                if (!isValid) {
                    e.preventDefault(); // Previene el envío del formulario si la validación falla
                }
            });

            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                $('#<%= btnSubmit.ClientID %>').off('click').on('click', function (e) {
                    var isValid = true;

                    var name = $('#<%= txtName.ClientID %>').val().trim();
                    if (name === '') {
                        $('#nameError').show();
                        isValid = false;
                    } else {
                        $('#nameError').hide();
                    }

                    var email = $('#<%= txtEmail.ClientID %>').val().trim();
                    var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    if (email === '' || !emailRegex.test(email)) {
                        $('#emailError').show();
                        isValid = false;
                    } else {
                        $('#emailError').hide();
                    }

                    if (!isValid) {
                        e.preventDefault();
                    }
                });
            });
        });
    </script>
</body>
</html>