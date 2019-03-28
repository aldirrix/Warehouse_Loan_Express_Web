import * as React from 'react'
import Card from '@material-ui/core/Card';
import CardContent from '@material-ui/core/CardContent';
import Button from '@material-ui/core/Button';
import Typography from '@material-ui/core/Typography';
import TextField from '@material-ui/core/TextField';
import Dialog from '@material-ui/core/Dialog';
import DialogActions from '@material-ui/core/DialogActions';
import DialogContent from '@material-ui/core/DialogContent';
import DialogContentText from '@material-ui/core/DialogContentText';
import DialogTitle from '@material-ui/core/DialogTitle';
import Select from '@material-ui/core/Select';
import FormControl from '@material-ui/core/FormControl';
import InputLabel from '@material-ui/core/InputLabel';
import Input from '@material-ui/core/Input';
import CustomDialog from './CustomDialog';

const styles = {
	available: {
		width: "275px",
		height: "180px",
		cursor: "pointer",
		margin: "8px",
	},
	unavailable: {
		width: "275px",
		height: "180px",
		cursor: "no-drop",
		background: "#CACACA",
		margin: "8px",
	},
	bullet: {
		display: 'inline-block',
		margin: '0 2px',
		transform: 'scale(0. 8)',
	},
	title: {
		marginBottom: 16,
		fontSize: 14,
	},
	pos: {
		marginBottom: 12,
	},
	itemsContainer: {
		display: "flex",
		flexDirection: "row",
		flexWrap: "wrap",
		alignContent: "space-between",
		justifyContent: "center",
		alignItems: "right",
	},
	button: {
		margin: "8px",
		background: "#000",
		color: "#FFF"

	},
	input: {
	    width: "60%",
	    padding: "12px 20px",
	    margin: "8px 0",
	    display: "inline-block",
	    border: "1px solid #ccc",
	    borderRadius: "4px",
	    boxSizing: "border-box"
	},
	formControl: {
		margin: "8px",
		minWidth: 120,
	},
	dialogBold: {
		fontWeight: "bold"
	}
};

export default class Items extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
			displayItems: props.items,
			carreers: props.carreers,
			basket: [],
			search: '',
			open: false,
			warningOpen: false,
			carreerID: 1,
			name: "",
			studentID: "",
			item: {},
			index: false,
			requestDialog: false,
			previousPetitionItems: [],
			currentPetitionItem: []
		};
	}

	onCardClick = (item, index) => {
		this.setState({warningOpen: true, item, index});
	};
	handleWarningConfirm = () => {
		let {basket, displayItems, item, index} = this.state;
		const foundIndex = basket.findIndex(basketItem => basketItem.id === item.id);
		if(foundIndex !== -1){
			basket[foundIndex].quantity++;
		}
		else{
			basket.push({id: item.id, name: item.name, quantity: 1})
		}
		displayItems[index].available--;
		this.setState({basket, displayItems, warningOpen: false});
	};
	handleWarningClose = () => {
		this.setState({warningOpen: false});
	}
	onSearchChange = (event) => {
		const displayItems = this.props.items.filter(item => item.name.toUpperCase().includes(event.target.value.toUpperCase()));
		this.setState({search: event.target.value, displayItems});
	};
  	handleClickOpen = () => {
		this.setState({ open: true });
	};
	handleClickRequest = () => {
		this.setState({ open: true, requestDialog: true });
	};
	handleClose = () => {
		this.setState({ open: false, requestDialog: false });
	};
	isBasketEmpty = () => {
		return !this.state.basket.length;
	};
	handleChange = name => async (event) => {
		this.setState({ [name]: event.target.value });
  	};
  	handleOrderConfirm = async () => {
  		const {basket, carreerID, name, studentID} = this.state;
		if(!basket || !carreerID || !name || !studentID) {
			alert("Por favor introduce los datos necesarios");
		}
		const orderResponse = await fetch("/order", {
			method: 'POST',
			body: JSON.stringify({basket, carreerID, name, studentID}), // data can be `string` or {object}!
			headers:{
				'Content-Type': 'application/json'
			}
		});
		if(orderResponse.status !== 200){
			alert("Ocurrió un Error al crear apartado, por favor refresca la pestaña (F5) e intenta de nuevo")
		} else {
			alert("Apartado realizado correctamente Tienes 30 minutos para presentarte en talleres o será eliminado");
		}
		this.setState({ open: false, basket: [] });
  	};
  	handleClear = () =>{
  		this.setState({ displayItems: this.props.items, search: "", open: false, basket: [] });
	}


  	render() {
		  const {displayItems, carreers, carreerID, search, basket, item, name, studentID} = this.state;
		return (
			<div>
				<div>
					<input
						style={styles.input}
						type="text"
						value={ search }
						onChange={ this.onSearchChange }
						placeholder="Buscar herramienta"
					/>
					<Button
						style={styles.button}
						size="small"
						onClick={this.handleClickOpen}
						disabled={this.isBasketEmpty()}
					>
						Apartar herramienta
					</Button>
					<Button
						style={styles.button}
						size="small"
						onClick={this.handleClickRequest}
					>
						Realizar Petición
					</Button>
				</div>
				<Dialog
					open={this.state.open}
					onClose={this.handleClose}
					aria-labelledby="form-dialog-title"
				>
					<DialogTitle id="form-dialog-title">Apartar</DialogTitle>
					<DialogContent>
						<DialogContentText>
						  	Presionando el boton de confirmación tendrás 30 minutos para recoger la herramienta o será eliminado el apartado automáticamente.
						</DialogContentText>
						<DialogContentText>
						  	Por favor revisa que esté completa tu orden.
						</DialogContentText>
						{basket.map(item => (
							<DialogContentText style={styles.dialogBold} key={item.id}>
							  	{item.name} ({item.quantity})
							</DialogContentText>))}
						<TextField
							style={styles.formControl}
						  	autoFocus
						  	margin="dense"
						  	id="name"
						  	label="Nombre"
						  	fullWidth
						  	onChange={this.handleChange('name')}
						/>
						<TextField
							style={styles.formControl}
						  	margin="dense"
						  	id="studentID"
						  	label="Registro"
							fullWidth
							type="number"
						  	onChange={this.handleChange('studentID')}
						/>
						<FormControl style={styles.formControl}>
							<InputLabel htmlFor="age-native-simple">Carrera</InputLabel>
							<Select
								native
								value={carreerID}
								onChange={this.handleChange('carreerID')}
								input={<Input id="age-native-simple" />}
							>
								{carreers.map( (carreer) => (
									<option key={carreer.id} value={carreer.id}>{carreer.name}</option>
								))}
							</Select>
						</FormControl>
					</DialogContent>
					<DialogActions>
						<Button
							onClick={this.handleOrderConfirm}
							color="primary"
							disabled={!basket || !carreerID || !name || !studentID}
						>
					  		Confirmar
						</Button>
						<Button onClick={this.handleClose} color="primary">
					  		Cancelar
						</Button>
						{/*<Button onClick={this.handleClear} color="primary">
					  		Limpiar Orden
						</Button>*/}
					</DialogActions>
				</Dialog>
				<CustomDialog
					open={this.state.requestDialog}
					carreers={carreers}
					close={this.handleClose}
				/>
				<Dialog
					open={this.state.warningOpen}
					onClose={this.handleWarningClose}
					aria-labelledby="form-dialog-title"
				>
					<DialogTitle id="form-dialog-title">Agregar a Orden</DialogTitle>
					<DialogContent>
						<DialogContentText style={styles.dialogBold}>
						  	Desea Agregar {item.name} a la orden?
						</DialogContentText>
					</DialogContent>
					<DialogActions>
						<Button onClick={this.handleWarningConfirm} color="primary">
					  		Confirmar
						</Button>
						<Button onClick={this.handleWarningClose} color="primary">
					  		Cancelar
						</Button>
					</DialogActions>
				</Dialog>
				<div style={styles.itemsContainer}>
					{displayItems.map( (item, index) => (
						<Card
							style={ item.available ? styles.available : styles.unavailable }
							key={ item.id }
							onClick={ item.available ? this.onCardClick.bind(this, item, index) : ()=>{} }
							>
					        <CardContent>
								<Typography style={styles.title}>
									{item.name}
								</Typography>
								<Typography variant="headline" component="h2">
									Disponibles: {item.available}
								</Typography>
							</CardContent>
						</Card>))}
				</div>
			</div>
		)
	}
}