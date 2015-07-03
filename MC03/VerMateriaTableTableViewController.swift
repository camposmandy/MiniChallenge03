//
//  VerMateriaTableTableViewController.swift
//  MC03
//
//  Created by João Marcos on 21/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class VerMateriaTableTableViewController: UITableViewController {

    
    @IBOutlet weak var lblNomeMateria: UILabel!
    @IBOutlet weak var lblNomeProfessor: UILabel!
    @IBOutlet weak var lblCargaHoraria: UILabel!
    @IBOutlet weak var lblDom: UILabel!
    @IBOutlet weak var lblSeg: UILabel!
    @IBOutlet weak var lblTer: UILabel!
    @IBOutlet weak var lblQua: UILabel!
    @IBOutlet weak var lblQui: UILabel!
    @IBOutlet weak var lblSex: UILabel!
    @IBOutlet weak var lblSab: UILabel!
    @IBOutlet weak var lblPercFaltas: UILabel!
    @IBOutlet weak var lblMedia: UILabel!
    
    var myColor = UIColor(red: 38/255, green: 166/255, blue: 91/255, alpha: 1)
    
    var semana: Array<DiasSemana>!
    var materiaAux: Materia!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preencherLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func preencherLabels(){
        var caract :  Character
        var auxCaract : String = ""
        var i = 0
        if count(materiaAux.nomeMateria) > 15{
            for index in indices(materiaAux.nomeMateria){
                if i <= 15{
                    caract = materiaAux.nomeMateria[index]
                    auxCaract += "\(caract)"
                    self.navigationItem.title = "\(auxCaract)..."
                }
                i++
            }
        } else {
            self.navigationItem.title = materiaAux.nomeMateria
        }
        
        lblNomeMateria.text = materiaAux.nomeMateria
        lblNomeProfessor.text = materiaAux.nomeProfessor
        lblMedia.text = "\(materiaAux.media)"
        lblCargaHoraria.text = "\(materiaAux.cargaHoraria) Aulas"

        var ix = materiaAux.cargaHoraria.doubleValue * materiaAux.faltas.doubleValue * 0.01
        var ii = Int(ix)
        lblPercFaltas.text = "\(materiaAux.faltas)%  (\(ii) Aulas)"
        
        var dias = materiaAux.possuiSemana.allObjects as NSArray
        for i in 0...dias.count-1 {
            var nomeDia = (dias.objectAtIndex(i) as! DiasSemana).nomeDia
            if nomeDia == "Domingo" {
                lblDom.textColor = myColor
            }
            if nomeDia == "Segunda" {
                lblSeg.textColor = myColor
            }
            if nomeDia == "Terça" {
                lblTer.textColor = myColor
            }
            if nomeDia == "Quarta" {
                lblQua.textColor = myColor
            }
            if nomeDia == "Quinta" {
                lblQui.textColor = myColor
            }
            if nomeDia == "Sexta" {
                lblSex.textColor = myColor
            }
            if nomeDia == "Sábado" {
                lblSab.textColor = myColor
            }
        }
    }
    
    func alert(){
        let alerta: UIAlertController = UIAlertController(title: "Atenção", message: "Certeza que deseja apagar essa matéria?", preferredStyle: .Alert)
        
        let ok: UIAlertAction = UIAlertAction(title: "Ok", style: .Default) { action -> Void in
            MateriaManager.sharedInstance.deletar(self.materiaAux)
            MateriaManager.sharedInstance.salvar()
            self.navigationController?.popViewControllerAnimated(true)
        }
        alerta.addAction(ok)
        
        let cancelar: UIAlertAction = UIAlertAction(title: "Cancelar", style: .Default) { action -> Void in
            
        }
        alerta.addAction(cancelar)
        self.presentViewController(alerta, animated: true, completion: nil)
        
    }
    
    @IBAction func btnApagarMateria(sender: AnyObject) {
       alert()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editarMateria" {
            let VC = segue.destinationViewController as! EditarMateriaTableViewController
            VC.materia = materiaAux
        }
    }
}
