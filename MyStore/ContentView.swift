//
//  ContentView.swift
//  MyStore
//
//  Created by Rafael Silva on 04/09/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Cliente.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Cliente.vip, ascending: false)]
    ) var clientes:FetchedResults<Cliente>
    
    var body: some View {
            NavigationView{
                VStack{
                    List{
                        ForEach(clientes, id: \.self){
                            cli in
                            
                            HStack{
                            Text("\(cli.nome ??  "--")")
                                if(cli.vip){
                                    Label("",systemImage: "star")
                                }
                               
                            }
                        }
                    }.navigationBarTitle("Lista Clientes",displayMode: .inline)
                    HStack{
                        NavigationLink("Novo Cliente", destination: NewClientView())
                    }
                }
                
            }
        
        
    }
    
    
    struct NewClientView:View {
       @State var txtNome = ""
       @State var idade = ""
       @State var vip = false
        
        @Environment(\.managedObjectContext) var managedObjectContext
        
        @Environment(\.presentationMode) var presentation
        
        var body: some View {
            VStack{
                TextField("Digite nome do cliente",text : $txtNome).textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Digite idade",text : $idade).textFieldStyle(RoundedBorderTextFieldStyle()).keyboardType(/*@START_MENU_TOKEN@*/.numberPad/*@END_MENU_TOKEN@*/)
                
                Toggle("Cliente vip?", isOn:$vip)
                Button("Salvar") {
                    
                    let cliente = Cliente(context: managedObjectContext)
                    
                    cliente.nome = txtNome
                    cliente.idade = Int32(idade) ?? 0
                    cliente.vip = vip
                    
                    PersistenceController.banco.save()
                    
                    self.presentation.wrappedValue.dismiss()
                        }

                
                
            }.padding().navigationTitle("Novo Cliente")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

