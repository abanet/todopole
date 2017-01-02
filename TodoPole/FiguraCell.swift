//
//  VideoCell.swift
//  TodoPole
//
//  Created by Alberto Banet on 5/12/16.
//  Copyright © 2016 Alberto Banet. All rights reserved.
//

import UIKit
import Parse

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class FiguraCell: BaseCell {
   
    var figura: Figura? {
        didSet {
            setupImagenFigura()
        }
    }
   

    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.backgroundColor = ColoresApp.lightPrimary
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let autorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Medium", size:15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ciro Esposito"
        label.textColor = UIColor.white //ColoresApp.primaryText
        return label
    }()
    
    let nombreEscuelaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Light", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Escuela de Pole Dance"
        label.textColor = UIColor.white
        return label
    }()
    
    
    let nombreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Medium", size:15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bombero loco"
        label.textColor = UIColor.white //ColoresApp.primaryText
        return label
    }()
    
    let nivelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Medium", size:12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nivel 1"
        label.textColor = UIColor.white //ColoresApp.primaryText
        return label
    }()
    
    let tipoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Medium", size:12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Giro"
        label.textColor = UIColor.white //ColoresApp.primaryText
        return label
    }()
  
    override func setupViews() {
        addSubview(thumbnailImageView)
        //  Gradientes superior e inferior
        //setupGradientLayer()
        
        addSubview(autorLabel)
        addSubview(nombreLabel)
        // addSubview(tipoLabel) // Por ahora no ponemos el tipo
        addSubview(nivelLabel)
        addSubview(nombreEscuelaLabel)
        
        //  Imagen de la figura. Ocupa todo el fondo de la celda
        
        addConstraintsWithFormat(format: "V:|[v0]|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: thumbnailImageView)

        
        //  Nombre del autor
        let margins = self.layoutMarginsGuide
        autorLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        addConstraint(NSLayoutConstraint(item: autorLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 8))
        
        //  Nombre de la escuela
        nombreEscuelaLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        addConstraint(NSLayoutConstraint(item: nombreEscuelaLabel, attribute: .top, relatedBy: .equal, toItem: autorLabel, attribute: .firstBaseline, multiplier: 1, constant: 0))
        
        //  Nombre de la figura
        nombreLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        addConstraint(NSLayoutConstraint(item: nombreLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier:1, constant: 0))
        
        // tipo de figura
        // tipoLabel.leadingAnchor.constraint(equalTo: nombreLabel.leadingAnchor).isActive = true
        //addConstraint(NSLayoutConstraint(item: tipoLabel, attribute: .bottom, relatedBy: .equal, toItem: nombreLabel, attribute: .top, multiplier:1, constant: 0))
        
        //  nivel de la figura
        nivelLabel.leadingAnchor.constraint(equalTo: nombreLabel.leadingAnchor).isActive = true
        addConstraint(NSLayoutConstraint(item: nivelLabel, attribute: .bottom, relatedBy: .equal, toItem: nombreLabel, attribute: .top, multiplier: 1, constant: 0))
        
    }
    
    // Establecemos un gradiente en la parte inferior de la fotografía para que se vea mejor la información que pondemos.
    private func setupGradientLayer(){
        let gradienteInferior = CAGradientLayer()
        let gradienteSuperior = CAGradientLayer()
        gradienteInferior.frame = self.bounds
        gradienteSuperior.frame = self.bounds
        gradienteInferior.colors = [UIColor.clear.cgColor, ColoresApp.lightPrimary.cgColor]
        gradienteSuperior.colors = [ColoresApp.lightPrimary.cgColor, UIColor.clear.cgColor]

        gradienteInferior.locations = [0.8, 1.0]
        gradienteSuperior.locations = [0.0, 0.3]
        
        self.layer.addSublayer(gradienteInferior)
        self.layer.addSublayer(gradienteSuperior)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
    }
    
    
    func setupTextosFigura(){
        autorLabel.text  =  figura?.autor ?? ""
        nombreLabel.text =  figura?.nombre ?? ""
        tipoLabel.text   =  figura?.tipo ?? ""
        if let nivel = figura?.nivel {
            nivelLabel.text  =  "Nivel \(nivel)"
        } else {
            nivelLabel.text  = ""
        }
        nombreEscuelaLabel.text = figura?.escuela?.nombre ?? ""
    }
    
    func resetearTextosCelda(){
        self.autorLabel.text = ""
        self.nivelLabel.text = ""
        self.nombreLabel.text = ""
        self.tipoLabel.text = ""
        self.nombreEscuelaLabel.text = ""
    }
    
    func setupImagenFigura() {
        // actualizar la imagen de la figura
        thumbnailImageView.loadImageUsingPFFile(fileFoto: figura?.fileFoto){
            self.setupTextosFigura()
        }
    }
    
    
}