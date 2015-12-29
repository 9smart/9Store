/*
============================================================================
 Name        : AOSync.h
 Author      : 
 Version     :
 Copyright   : All rights reserved
 Description : Class for completion of Active object wait requests
============================================================================
*/


#ifndef __AOSYNC_H
#define __AOSYNC_H

#include <e32base.h>
#include <e32def.h>



class CAOSync : public CActive
{
  public:
  
    /*!
	@function NewL
	   
	@discussion Create a CAOSync object
	@result a pointer to the created instance of CAOSync
	*/
  
	static CAOSync* NewL();
	
	/*!
	@function ~CAOSync
	  
	@discussion Destroy the object and release all memory objects
	*/
	
	virtual ~CAOSync();
     
    void Execute();

  protected:
  
   	/*!
	@function ConstructL
	  
	@discussion  Perform the second phase construction of a CAOSync object
	*/
    
	void ConstructL();

    // From CActive
	void DoCancel();
	//TInt RunError(TInt aError);
	void RunL();

    
  private: 
  
  	CAOSync();
  	   
    // Stack objects
    CActiveSchedulerWait* iWait;
    };

#endif //__AOSYNC_H

//  End of File  
