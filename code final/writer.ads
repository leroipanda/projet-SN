generic

    file_name : String;

package writer is

    type T_Size_Text is mod 2**(8*4);
    type T_Byte is mod 2**8;
    type T_Code is record
	byte : T_Byte;
	length : Integer;
    end record;


    procedure Create_Compressed_File;

    procedure Write_Byte(code : in T_Code);

    procedure Write_Bit(i : in Integer);

    procedure Write_Integer(i : in Integer);

    procedure Write_Text_Size;

    procedure Force_Write_Buffer;

    procedure Close_Compressed_File;

private

    buffer : T_Code;
    text_size : T_Size_Text;

    procedure Update_Buffer(code : in T_Code);

    procedure Clean_Buffer;

    procedure Write_Buffer;


end writer;
