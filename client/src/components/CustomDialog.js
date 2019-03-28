import React from 'react';
import PropTypes from 'prop-types';
import deburr from 'lodash/deburr';
import Downshift from 'downshift';
import { withStyles } from '@material-ui/core/styles';
import TextField from '@material-ui/core/TextField';
import Paper from '@material-ui/core/Paper';
import MenuItem from '@material-ui/core/MenuItem';
import Chip from '@material-ui/core/Chip';
import Button from '@material-ui/core/Button';
import Dialog from '@material-ui/core/Dialog';
import DialogActions from '@material-ui/core/DialogActions';
import DialogContent from '@material-ui/core/DialogContent';
import DialogContentText from '@material-ui/core/DialogContentText';
import DialogTitle from '@material-ui/core/DialogTitle';
import Select from '@material-ui/core/Select';
import FormControl from '@material-ui/core/FormControl';
import InputLabel from '@material-ui/core/InputLabel';
import Input from '@material-ui/core/Input';

let suggestions = [];
let selectedItems = [];

(async () => {
    const response = await fetch(`/requests`);
    suggestions = await response.json();
})();

function renderInput(inputProps) {
  const { InputProps, classes, ref, ...other } = inputProps;

  return (
    <TextField
      InputProps={{
        inputRef: ref,
        classes: {
          root: classes.inputRoot,
          input: classes.inputInput,
        },
        ...InputProps,
      }}
      {...other}
    />
  );
}

function renderSuggestion({ suggestion, index, itemProps, highlightedIndex, selectedItem }) {
  const isHighlighted = highlightedIndex === index;
  const isSelected = (selectedItem || '').indexOf(suggestion.name) > -1;

  return (
    <MenuItem
      {...itemProps}
      key={suggestion.id}
      selected={isHighlighted}
      component="div"
      style={{
        fontWeight: isSelected ? 500 : 400,
      }}
    >
      {suggestion.name}
    </MenuItem>
  );
}
renderSuggestion.propTypes = {
  highlightedIndex: PropTypes.number,
  index: PropTypes.number,
  itemProps: PropTypes.object,
  selectedItem: PropTypes.shape(),
  suggestion: PropTypes.shape({ label: PropTypes.string }).isRequired,
};

function getSuggestions(value) {
  const inputValue = deburr(value.trim()).toLowerCase();
  const inputLength = inputValue.length;
  let count = 0;

  return inputLength === 0
    ? []
    : suggestions.filter(suggestion => {
        const keep =
          count < 5 && suggestion.name.toLowerCase().includes(inputValue);

        if (keep) {
          count += 1;
        }

        return keep;
      });
}

class DownshiftMultiple extends React.Component {
  state = {
    inputValue: '',
    selectedItem: [],
    newId: 100001,
  };

  handleKeyDown = event => {
    const { inputValue, selectedItem } = this.state;
    if (selectedItem.length && !inputValue.length && event.key === 'Backspace') {
      this.setState({
        selectedItem: selectedItem.slice(0, selectedItem.length - 1),
      });
    }

    if (inputValue.length && event.key === 'Enter') {
        this.setState({
          selectedItem: [ ...selectedItem, { id: this.state.newId, name: inputValue } ],
          inputValue: "",
          newId: this.state.newId + 1,
        });
      }
  };

  handleInputChange = event => {
    this.setState({ inputValue: event.target.value });
  };

  handleChange = item => {
    let { selectedItem } = this.state;

    if (selectedItem.indexOf(item) === -1) {
      selectedItem = [...selectedItem, item];
    }

    this.setState({
      inputValue: '',
      selectedItem,
    });
  };

  handleDelete = item => () => {
    this.setState(state => {
      const selectedItem = [...state.selectedItem];
      selectedItem.splice(selectedItem.indexOf(item), 1);
      return { selectedItem };
    });
  };

  componentDidUpdate(prevProps) {
    if (prevProps.buttonEnabled !== !!selectedItems.length) {
      if(selectedItems.length) {
        this.props.enableButton(true);
      } else {
        this.props.enableButton(false);
      }
    }
  }
  render() {
    selectedItems = this.state.selectedItem;
    const { classes } = this.props;
    const { inputValue, selectedItem } = this.state;

    return (
      <Downshift
        id="downshift-multiple"
        inputValue={inputValue}
        onChange={this.handleChange}
        selectedItem={selectedItem}
      >
        {({
          getInputProps,
          getItemProps,
          isOpen,
          inputValue: inputValue2,
          selectedItem: selectedItem2,
          highlightedIndex,
        }) => (
          <div className={classes.container}>
            {renderInput({
              fullWidth: true,
              classes,
              InputProps: getInputProps({
                startAdornment: selectedItem.map(item => (
                  <Chip
                    key={item.id}
                    tabIndex={-1}
                    label={item.name}
                    className={classes.chip}
                    onDelete={this.handleDelete(item)}
                  />
                )),
                onChange: this.handleInputChange,
                onKeyDown: this.handleKeyDown,
                placeholder: 'Selecciona una o múltiples (presiona enter para crear nueva)',
              }),
              label: 'Herramientas',
            })}
            {isOpen ? (
              <Paper className={classes.paper} square>
                {getSuggestions(inputValue2).map((suggestion, index) =>
                  renderSuggestion({
                    suggestion,
                    index,
                    itemProps: getItemProps({ item: suggestion }),
                    highlightedIndex,
                    selectedItem: selectedItem2,
                  }),
                )}
              </Paper>
            ) : null}
          </div>
        )}
      </Downshift>
    );
  }
}

class CustomDialog extends React.Component {
  state = {
    carreerID: 1,
    openDialog: this.props.openDialog,
  };

  handleChange = name => async (event) => {
		this.setState({ [name]: event.target.value });
  };
  handleOrderConfirm = async () => {
    const {carreerID} = this.state;
    const orderResponse = await fetch("/request", {
      method: 'POST',
      body: JSON.stringify({selectedItems, carreerID}), // data can be `string` or {object}!
      headers:{
        'Content-Type': 'application/json'
      }
    });
    if(orderResponse.status !== 200){
      alert("Ocurrió un Error al crear peticioón, por favor refresca la pestaña (F5) e intenta de nuevo")
    } else {
      alert("Petición realizada correctamente");
    }
    this.props.close();
    this.setState({ openDialog: false });
  };

  enableButton = (condition) => {
    this.setState({buttonEnabled: condition});
  }
  render() {
    const {carreers} = this.props;
    const {carreerID} = this.state;
    return (
      <Dialog
          open={this.props.openDialog}
          onClose={this.props.close}
          aria-labelledby="form-dialog-title"
      >
          <DialogTitle id="form-dialog-title">Peticiones</DialogTitle>
          <DialogContent>
              <DialogContentText>
                  En esta sección podrás pedir herramienta en caso de no tener disponible y en el caso de tener suficientes peticiones, el cuerpo administrativo decidirá si se adquiere en un futuro.
              </DialogContentText>
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
              <div className={this.props.classes.root}>
              <div className={this.props.classes.divider} />
                <DownshiftMultiple buttonEnabled={!!selectedItems.length} enableButton={this.enableButton} classes={this.props.classes}/>
              </div>
          </DialogContent>
          <DialogActions>
              <Button disabled={!this.state.buttonEnabled} onClick={this.handleOrderConfirm} color="primary">
                  Confirmar
              </Button>
              <Button onClick={this.props.close} color="primary">
                  Cancelar
              </Button>
          </DialogActions>
      </Dialog>
    );
  }
}

DownshiftMultiple.propTypes = {
  classes: PropTypes.object.isRequired,
};

const styles = theme => ({
  root: {
    flexGrow: 1,
    height: 250,
  },
  container: {
    flexGrow: 1,
    position: 'relative',
  },
  paper: {
    position: 'absolute',
    zIndex: 1,
    marginTop: theme.spacing.unit,
    left: 0,
    right: 0,
  },
  chip: {
    margin: `${theme.spacing.unit / 2}px ${theme.spacing.unit / 4}px`,
  },
  inputRoot: {
    flexWrap: 'wrap',
  },
  inputInput: {
    width: 'auto',
    flexGrow: 1,
  },
  divider: {
    height: theme.spacing.unit * 2,
  },
});

function IntegrationDownshift(props) {
  const { classes, carreers, open, close } = props;

  return (
    <CustomDialog
      openDialog={open}
      carreers={carreers}
      classes={classes}
      close={close}
    >
    </CustomDialog>
  );
}

IntegrationDownshift.propTypes = {
  classes: PropTypes.object.isRequired,
};

export default withStyles(styles)(IntegrationDownshift);


{/*  */}