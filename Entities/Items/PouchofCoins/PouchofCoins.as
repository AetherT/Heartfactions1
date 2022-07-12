#include "Help.as";

//When this is created
void onInit( CBlob@ this )
{
	HelpText help;//add the help text
	this.addCommandID( "summon coin" );//add the command (used for when the button is pressed)
	SetHelp( this, "help use carried", "Help!", "Hello i am being used","ah i love being carried", 20);//create add the help text
}

//create the button with the command created above^
void GetButtonsFor( CBlob@ this, CBlob@ caller )
{
	CBitStream params;
	params.write_u16(caller.getNetworkID());
	
	caller.CreateGenericButton( 11, Vec2f_zero, this, this.getCommandID("summon coin"), "Open pouch; Get coins!", params );
	//Create the button 
}
//When the button is pressed
void onCommand( CBlob@ this, u8 cmd, CBitStream @params )
{
	//If the button is the right button (one object can have more then one button, this is why you need to check for the command)
	if (cmd == this.getCommandID("summon coin"))
	{

		//Do the coin spawning stuff
		server_DropCoins(this.getPosition(),5);
		this.server_Die();
	}
}