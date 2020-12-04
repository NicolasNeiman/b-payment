const circle = () => {
  const svgs = document.querySelectorAll('svg');
  const circles = document.querySelectorAll('circle');
  svgs.forEach((svg) => {
    svg.classList.add("circle-shape");
  });
  circles.forEach((circle) => {
    circle.classList.add("white-circle");
    circle.classList.add("white-circle-starts");
    setTimeout(() => {
      circle.classList.add("white-circle-ends");
    }, 1000);
  });

}

export { circle }
