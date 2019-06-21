package body Contacts_app.Utilities is

   ------------------------
   -- Verify_Certificate --
   ------------------------
   function Verify_Certificate (Cert : Net.SSL.Certificate.Object)
                                return Boolean is
   begin
      return Net.SSL.Certificate.Verified (Cert);
   end;

end Contacts_app.Utilities;
