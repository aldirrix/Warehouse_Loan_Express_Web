import React, { Component } from 'react';
import './App.css';
import Items from './components/Items';

class App extends Component {
  state = {
    items: [],
    carreers: []
  };

  componentWillMount() {
    this.getData()
      .then(res => this.setState({ items: res.items, carreers: res.carreers }))
      .catch(err => console.log(err));
  }

  getData = async () => {
    const items = await fetch('/items');
    const itemsBody = await items.json();
    if (items.status !== 200) throw Error(itemsBody.message);
    const carreers = await fetch('/carreers');
    const carreersBody = await carreers.json();
    if (carreers.status !== 200) throw Error(itemsBody.message);
    return {items: itemsBody.rows, carreers: carreersBody.rows};
  };

  render() {
    return (
      <div className="App">
        {this.state.items.length && <Items items={this.state.items} carreers={this.state.carreers}/>}
      </div>
    );
  }
}

export default App;