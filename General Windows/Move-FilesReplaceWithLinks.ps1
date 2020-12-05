<#Goals 1

    [x] Let the user specify the source folder or path [x]
    [x] Let the user specify the target folder or path
    [x] Let the user specify the last modified date or number of days
    [x] Include appropriate error handling

    Goals 2

        Support -Whatif
        Accept the source folder or path from the pipeline
    [x] Support optional recursion
        Let the user exclude files by extension
        Create an audit trail
        Run as a background job

    Goals 3

        Improve script
#>

function Move-FilesReplaceWithLinks {


  [cmdletBinding()]
  param
  (
   
    [String[]]
    [Parameter(Mandatory = $true)]
    $SourceFolder,
    [String]
    [Parameter(Mandatory = $true)]
    $TargetFolder,       
    [Double]
    [Parameter(Mandatory = $true)]
    $LastModified,
    [Parameter(Mandatory = $false)]
    [Switch]$Recurse
    
  )
   
  
  
    if ($Recurse -eq $true )
    {
      $GetSourceFiles = Get-ChildItem -Path $SourceFolder -file -Recurse | Where-Object  {(Get-Date).AddDays(-$LastModified) -le $_.LastWriteTime}
    }
    else {
    
      $GetSourceFiles = Get-ChildItem -Path $SourceFolder -File | Where-Object  {(Get-Date).AddDays(-$LastModified) -le $_.LastWriteTime}
    }
     
     
    
 
    

      foreach ($SourceFile in $GetSourceFiles)
      { 
       
        try
        {
          Move-Item -Path $sourceFile.FullName -Destination  (Join-Path -Path $TargetFolder -ChildPath ($sourceFile.Name)) -ErrorAction Stop  
          New-Item -ItemType SymbolicLink -Path $sourceFile.FullName  -Target (Join-Path -Path $TargetFolder -ChildPath ($sourceFile.Name))      
        }
        catch
        {
          Write-Warning -Message "Cannot create file $sourceFile.name, file already exists!"
        }    
             

      }

    }
        
  
  

  Move-FilesReplaceWithLinks -SourceFolder C:\Powershell\TestFolder1 -Recurse -TargetFolder C:\Powershell\TestFolder3 -LastModified 6