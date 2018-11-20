with Liste_Generique;
with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;           use Ada.Float_Text_IO;
procedure exemple_liste_generique is
   package liste_Entier is new Liste_Generique(Integer);
   use liste_Entier;
   test : T_Liste;
begin
   
   Initialiser(test);
   if Est_Vide(test) then
      Put_Line("vide");
   end if;
   
   Ajouter_Element(test,2);
   Put( Integer'Image(Element_Debut(test)));
   Ajouter_Element(test,5);
   Put( Integer'Image(Element_Debut(test)));
   Supprimer_premier_Element(test);
   Put( Integer'Image(Element_Debut(test)));
   Supprimer_premier_Element(test);
   Put( Integer'Image(Element_Debut(test)));
  
   
   
end exemple_liste_generique;
