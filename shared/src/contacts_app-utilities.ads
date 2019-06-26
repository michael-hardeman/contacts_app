with AWS.Net.SSL.Certificate;

package Contacts_app.Utilities is

   use AWS;

   function Verify_Certificate (Cert : Net.SSL.Certificate.Object)
                                return Boolean;

end Contacts_app.Utilities;
