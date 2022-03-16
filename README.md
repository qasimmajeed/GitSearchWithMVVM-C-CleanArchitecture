# GitSearchWithMVVM-C-CleanArchitecture
Github repo search with using mvvm-c and clean architecture and using combine swift.

# Content


 * Overview
 * How To Run
 * App Features
 * App Screenshots

 # Overview
    This demo repo is created to summarize the implementation of clean architecure with MVVM-C.The main basic flow of the app is that View is having the viewmodel which contains all the logic to how to pull the data and pass it to the view in order to visible in the view. The main backbone of the architecure is the use-cases 
 
 * **Domain**: One the main layer where all the domain level things kept like entites, use-cases and the repository protocols.
   > 1. Entities : Contains all the busniess related entities for response and request.
   > 2. Repositories : Its contain all the repositories protocols as a abstraction.
   > 3. UseCases : Same as repositories abstraction its also having the use-cases of the whole application.Right now its containts the GitSearchUseCaseProtocols.
 
 * **Data**: This module is responsible for having all the implementation related to the domain like usecases and the repositories.
   > 1. Constants : Contains all data related constants like api url and the token for the github
   > 2. Extensions : Having the helpfull extensions for the aditional feature for current classes.
   > 4. Repositories : Its Contains the define implementation of repositories which is defined in the Domain module.
   > 5. UseCases : 
 
  * **Network Feature**:.
 
 
 
 
