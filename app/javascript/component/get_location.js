const getInput = (getlocation) => {
  const latitude = getlocation.coords.latitude;
  const longitude = getlocation.coords.longitude;

  const latitudeInput = document.getElementById('latitude');
  const longitudeInput = document.getElementById('longitude');
  latitudeInput.setAttribute('value', latitude);
  longitudeInput.setAttribute('value', longitude);

};

const locationToForm = (location) => {
  getInput(location)
};

const getLocation = () => {
  if (document.getElementById('latitude')) {
    if (navigator.geolocation) {
      const location = navigator.geolocation.getCurrentPosition(locationToForm);
    }
  }
};


export {getLocation}

