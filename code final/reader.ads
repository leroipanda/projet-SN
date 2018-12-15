generic

    file_name : String;

package reader is

   type T_Byte is mod 2**8;
   --procedure qui ouvre le fichier compresser entre
   --assure : fichier est ouvert
   --

   procedure Open_Compressed_File;
   --function qui renvoie la taille d'un fichier compressé
   --necessite : fichier ouvert
   --returne : integer

   function Read_Text_Size return Integer;

    --function qui renvoie le nombre de caractere du fichier compressé
   --necessite : fichier ouvert et taille dejà lu
   --returne : integer

    function Read_Tab_Huffman_Size return Integer;
   --procedure  qui lit un octet du fichier et le renvoie dans le buffer
   --necessite : fichier ouvert et taille dejà lu

   --assure ; le valeur
   --necesite : fichier non vide
    procedure Read_Octet;
    --procedure  qui lit le bit suivant dans le buffer
   --necessite : fichier ouvert et taille dejà lu

   --assure ; le valeur du bit est bonne
   --necesite : fichier non vide
   function Read_Bit return Integer;
    --procedure  qui renvoie la valeur du buffer
   --necessite : buffer initialiser une fois
   --retourn : integer
   --assure : le valeur revoyer est celle du buffer


    function Get_Buffer return T_Byte;



private

    buffer : T_Byte;

    procedure Update_Buffer(octet : in T_Byte);

    procedure Clean_Buffer;

end reader;
