using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace Avanzada_Tarea1
{
    // Clase para representar un usuario
    public class User
    {
        public string Name { get; set; }
        public string Email { get; set; }
    }

    public partial class Default : System.Web.UI.Page
    {

        // Lista para almacenar los usuarios. Usamos Session para que persista entre postbacks
        private List<User> RegisteredUsers
        {
            get
            {
                if (Session["RegisteredUsers"] == null)
                {
                    Session["RegisteredUsers"] = new List<User>();
                }
                return (List<User>)Session["RegisteredUsers"];
            }
            set { Session["RegisteredUsers"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Este método se ejecuta cada vez que la página se carga
            // Si no es un postback (primera carga de la página), o si es un postback
            // y queremos actualizar la tabla, la renderizamos.
            if (!IsPostBack) // Solo se ejecuta la primera vez que la página se carga
            {
                RenderUsersTable();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Este método se ejecuta cuando se hace clic en el botón btnSubmit
            // Los datos ya fueron validados por JavaScript en el cliente.

            string name = txtName.Text;
            string email = txtEmail.Text;

            // Crear un nuevo objeto User
            User newUser = new User { Name = name, Email = email };

            // Agregar el nuevo usuario a la lista
            RegisteredUsers.Add(newUser);

            // Limpiar los campos del formulario
            txtName.Text = string.Empty;
            txtEmail.Text = string.Empty;

            // Actualizar la tabla de datos
            RenderUsersTable();
        }

        private void RenderUsersTable()
        {
            // Construir la tabla HTML para mostrar los usuarios
            System.Text.StringBuilder sb = new System.Text.StringBuilder();

            if (RegisteredUsers.Any())
            {
                sb.Append("<table class='data-table'>");
                sb.Append("<thead><tr><th>Nombre</th><th>Correo Electrónico</th></tr></thead>");
                sb.Append("<tbody>");

                foreach (var user in RegisteredUsers)
                {
                    sb.Append("<tr>");
                    sb.AppendFormat("<td>{0}</td>", Server.HtmlEncode(user.Name)); // Codificar HTML para seguridad
                    sb.AppendFormat("<td>{0}</td>", Server.HtmlEncode(user.Email));
                    sb.Append("</tr>");
                }

                sb.Append("</tbody>");
                sb.Append("</table>");
            }
            else
            {
                sb.Append("<p>No hay datos registrados aún.</p>");
            }

            litData.Text = sb.ToString();
        }
    }
}