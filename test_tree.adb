with tree ;use tree;


procedure test_tree is





   procedure test_Initialize is
      arbre : T_Tree;
   begin
      pragma Assert (Is_Empty(arbre));

   end test_Initialize;

   procedure test_Get_Character is
      arbre1 : T_Tree;
      caractere1 :Character := 'a' ;
      arbre2 : T_Tree;
      caractere2 :Character := 'b' ;

   begin
      arbre1 :=  Create_Leaf(caractere1);
      arbre2 :=  Create_Leaf(caractere2);
      pragma Assert ( Get_Character(arbre2) = 'b');
      pragma Assert ( Get_Character(arbre1) = 'a');
   end test_Get_Character;

   procedure test_Add_Occurence is
      arbre : T_Tree;
      caractere :Character := 'a' ;
     begin
      arbre :=  Create_Leaf(caractere);
      for i in 1..50 loop
      Add_Occurence(arbre);
         pragma Assert (Get_Occurence(arbre)  = i);


         end loop;
   end test_Add_Occurence;

   procedure test_Get_Occurence is
      arbre1 : T_Tree;
      caractere :Character := 'a' ;
     begin
      arbre1 :=  Create_Leaf(caractere);
      for i in 1..50 loop
      Add_Occurence(arbre1);
         pragma Assert (Get_Occurence(arbre1)  = i);


      end loop;
   end test_Get_Occurence;

   procedure test_Get_Bit is
      arbre1 : T_Tree;
      caractere1 :Character := 'a' ;
      arbre2 : T_Tree;
      caractere2 :Character := 'b' ;
      arbre3 : T_Tree;
   begin
      arbre1 :=  Create_Leaf(caractere1);
      arbre2 :=  Create_Leaf(caractere2);
      pragma Assert(Get_Bit(arbre1 )=0);
      pragma Assert(Get_Bit(arbre2 )=0);
      --on construit un arbre plus complexe
      arbre3 := Bind(arbre1,arbre2);
      pragma Assert(Get_Bit(arbre1 )=0);
      pragma Assert(Get_Bit(arbre2 )=1);
   end test_Get_Bit;

   procedure test_Get_Children_Left is
      arbre1 : T_Tree;
      caractere1 :Character := 'a' ;
      arbre2 : T_Tree;
      caractere2 :Character := 'b' ;
      arbre3 : T_Tree;
      feuille_left : T_Tree;
   begin
      arbre1 :=  Create_Leaf(caractere1);
      arbre2 :=  Create_Leaf(caractere2);
      pragma Assert(Get_Bit(arbre1 )= 0);
      pragma Assert(Get_Bit(arbre2 )= 0);
      --on construit un arbre plus complexe
      arbre3 := Bind(arbre1,arbre2);
      feuille_left := Get_Children_Left(arbre3);
      pragma Assert (Get_Bit(arbre1 ) = Get_Bit(feuille_left) );
      pragma Assert (Get_Character(arbre1) =Get_Character(feuille_left));
      pragma Assert (Get_Occurence(arbre1) = Get_Occurence(feuille_left));
   end test_Get_Children_Left;

   procedure test_Get_Children_Right is
      arbre1 : T_Tree;
      caractere1 :Character := 'a' ;
      arbre2 : T_Tree;
      caractere2 :Character := 'b' ;
      arbre3 : T_Tree;
      feuille_right : T_Tree;
   begin
      arbre1 :=  Create_Leaf(caractere1);
      arbre2 :=  Create_Leaf(caractere2);
      pragma Assert(Get_Bit(arbre1 )= 0);
      pragma Assert(Get_Bit(arbre2 )= 0);
      --on construit un arbre plus complexe
      arbre3 := Bind(arbre1,arbre2);
      feuille_right := Get_Children_Right(arbre3);
      pragma Assert (Get_Bit(arbre2 ) = Get_Bit(feuille_right) );
      pragma Assert (Get_Character(arbre2) =Get_Character(feuille_right));
      pragma Assert (Get_Occurence(arbre2) = Get_Occurence(feuille_right));
   end test_Get_Children_Right;

   procedure test_Is_Empty is
      arbre1 : T_Tree;
      caractere1 :Character := 'a' ;
      arbre2 : T_Tree;
      caractere2 :Character := 'b' ;
 begin
      arbre1 :=  Create_Leaf(caractere1);
      pragma Assert (not Is_Empty(arbre1));
      pragma Assert ( Is_Empty(arbre2));
   end test_Is_Empty;

   procedure test_Is_Node is
      arbre1 : T_Tree;
      caractere1 :Character := 'a' ;
      arbre2 : T_Tree;
      caractere2 :Character := 'b' ;
      arbre3 : T_Tree;

   begin
      arbre1 :=  Create_Leaf(caractere1);
      arbre2 :=  Create_Leaf(caractere2);
      --on construit un arbre plus complexe
      arbre3 := Bind(arbre1,arbre2);
      pragma Assert (not Is_Node(arbre1));
      pragma Assert (not Is_Node(arbre2));
      pragma Assert ( Is_Node(arbre3));
   end test_Is_Node;

     procedure test_Create_Leaf is
      caractere :Character := 'a' ;
      arbre : T_Tree;
   begin
      arbre :=  Create_Leaf(caractere);
      pragma Assert (not Is_Empty(arbre)) ;
      pragma Assert ( Get_Character(arbre) = caractere);
      pragma Assert ( Get_Occurence(arbre) = 0);
      pragma Assert (not  Is_Node(arbre) );
   end test_Create_Leaf;

   procedure test_Bind is
      arbre1 : T_Tree;
      caractere1 :Character := 'a' ;
      arbre2 : T_Tree;
      caractere2 :Character := 'b' ;
      arbre3 : T_Tree;
      feuille_right : T_Tree;
      feuille_left : T_Tree;
   begin
      arbre1 :=  Create_Leaf(caractere1);
      arbre2 :=  Create_Leaf(caractere2);
      --on construit un arbre plus complexe
      arbre3 := Bind(arbre1,arbre2);
      --on regarde la feuille droite
      feuille_right := Get_Children_Right(arbre3);
      pragma Assert (Get_Bit(arbre2 ) = Get_Bit(feuille_right) );
      pragma Assert (Get_Character(arbre2) =Get_Character(feuille_right));
      pragma Assert (Get_Occurence(arbre2) = Get_Occurence(feuille_right));
      --on regarde la feuille gauche
      feuille_left := Get_Children_Left(arbre3);
      pragma Assert (Get_Bit(arbre1 ) = Get_Bit(feuille_left) );
      pragma Assert (Get_Character(arbre1) =Get_Character(feuille_left));
      pragma Assert (Get_Occurence(arbre1) = Get_Occurence(feuille_left));
      --on regarde la frequence
      pragma Assert (Get_Occurence(arbre1) +Get_Occurence(arbre2) = Get_Occurence(arbre3));
   end test_Bind;



begin

   test_Initialize;
   test_Get_Character;
   test_Add_Occurence;
   test_Get_Bit;
   test_Get_Children_Left;
   test_Get_Children_Right;
   test_Is_Empty;
   test_Is_Node;
   test_Create_Leaf;
   test_Bind;

end test_tree ;
